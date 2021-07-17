# -*- coding: utf-8 -*-

import os

import numpy as np
import tensorflow as tf

# change the tensorflow log level
# valid value is 0, 1, 2, 3
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'


def conv_core(input, kernel, result, stride=1):
    hight, width = input.shape
    kernel_size = kernel.shape[0]
    res = np.zeros((result.shape))

    for r in range(0, int(np.ceil((hight - kernel_size + 1)/float(stride)))):
        for c in range(0, int(
                np.ceil((width - kernel_size + 1)/float(stride)))):
            current_input = input[r:r+kernel_size, c: c+kernel_size]
            current_output = current_input * kernel
            conv_sum = np.sum(current_output)
            res[r, c] = conv_sum

    return res


def conv(input, kernel, stride=[1, 1], padding='VALID'):
    input_channel, hight, width = input.shape
    kernel_num, input_channel, kernel_size, kernel_size = kernel.shape
    output_channel = kernel_num
    if padding == 'VALID':
        result = np.zeros(
            [output_channel,
                int(np.ceil((hight - kernel_size + 1) / stride[0])),
                int(np.ceil((width - kernel_size + 1) / stride[0]))],
            np.float32)
    else:
        result = np.zeros(
            [output_channel, int(hight / stride[0]),
                int(width / stride[0])],
            np.float32)
        pad_hight = (hight - 1) * stride[0] + kernel_size - hight
        pad_top = int(pad_hight / 2)
        pad_down = pad_hight - pad_top

        pad_widht = (width - 1) * stride[0] + kernel_size - width
        pad_left = int(pad_widht / 2)
        pad_right = pad_widht - pad_left
        input = np.pad(
            input, ((0, 0), (pad_top, pad_down), (pad_left, pad_right)),
            'constant', constant_values=(0, 0))

    for out in range(output_channel):
        for in_channel in range(input_channel):
            channel_data = input[in_channel]
            tmp = conv_core(channel_data, kernel[out][in_channel],
                            result[0], stride=stride[0])
            # print(tmp)
            result[out, :, :] += tmp
    return result


def dwconv(input, kernel, point_kernel, stride=[1, 1], padding='VALID'):
    input_channel, hight, width = input.shape
    kernel_num, input_channel, kernel_size, kernel_size = kernel.shape
    point_num, point_in_channel, point_size, point_size = point_kernel.shape
    assert input_channel == kernel_num, \
        'DW Convert need input channel equals output channel'
    assert point_size == 1, \
        'Pointwise Convert kernel`s shape must be output * input * 1 * 1'
    assert point_in_channel == kernel_num, \
        'Pointwise input channel must be equel the Depthwise kernel output num'

    deconv_res = conv(input, kernel, stride=stride, padding=padding)
    final_res = conv(deconv_res, point_kernel)
    return final_res


def tfconv(input, kernel, strides=[1, 1, 1, 1], padding='VALID'):
    tf_input = tf.compat.v1.placeholder(shape=input.shape, dtype=tf.float32)
    tf_kernel = tf.compat.v1.placeholder(shape=kernel.shape, dtype=tf.float32)
    conv_res = tf.nn.conv2d(
        tf_input, tf_kernel, strides=strides, padding=padding)
    with tf.compat.v1.Session() as sess:
        out = sess.run(
            conv_res, feed_dict={tf_input: input, tf_kernel: kernel})
        # delete the axis==1
        # out = np.squeeze(out)
        return out


def tfdwconv(input, kernel, point_kernel,
             strides=[1, 1, 1, 1], padding='valid'):
    tf_input = tf.compat.v1.placeholder(shape=input.shape, dtype=tf.float32)
    tf_kernel = tf.compat.v1.placeholder(shape=kernel.shape, dtype=tf.float32)
    tf_point_kernel = tf.compat.v1.placeholder(
        shape=point_kernel.shape, dtype=tf.float32)
    conv_res = tf.nn.conv2d(
        tf_input, tf_kernel, strides=strides, padding=padding)
    dwconv_res = tf.nn.conv2d(
        conv_res, tf_point_kernel, strides=[1, 1, 1, 1], padding='VALID')
    with tf.compat.v1.Session() as sess:
        out = sess.run(
            conv_res, feed_dict={tf_input: input, tf_kernel: kernel})
        final_out = sess.run(
            dwconv_res, feed_dict={conv_res: out,
                                   tf_point_kernel: point_kernel})
        return final_out


def conv_c_style(input, kernel, stride=1):
    input_channel, input_size, input_size = input.shape
    kernel_channel, _input_channel, kernel_size, kernel_size = kernel.shape
    output_size = int(np.ceil((input_size - kernel_size + 1) / float(stride)))
    out_result = np.zeros([kernel_channel, output_size, output_size]).tolist()
    kernel_input = kernel.tolist()
    input_input = input.tolist()

    for channel in range(kernel_channel):
        for row in range(output_size):
            for col in range(output_size):
                for chan in range(input_channel):
                    for k_row in range(kernel_size):
                        for k_col in range(kernel_size):
                            out_result[channel][row][col] += \
                                kernel_input[channel][chan][k_row][k_col] *\
                                input_input[chan][
                                    stride*row+k_row][stride*col + k_col]

    return np.asarray(out_result)


def conv_c_style_splited(input, kernel, stride=1):
    input_channel, input_size, input_size = input.shape
    output_channel, _input_channel, kernel_size, kernel_size = kernel.shape
    output_size = int(np.ceil((input_size - kernel_size + 1) / float(stride)))
    out_result = np.zeros([output_channel, output_size, output_size]).tolist()
    kernel_input = kernel.tolist()
    input_input = input.tolist()

    def __singel_conv_c_style__(__input_input__, __kernel_input__,
                                __out_result__):
        for row in range(output_size):
            for col in range(output_size):
                for k_row in range(kernel_size):
                    for k_col in range(kernel_size):
                        __out_result__[row][col] += \
                            __kernel_input__[k_row][k_col] *\
                            __input_input__[
                                stride*row+k_row][stride*col + k_col]

    def splite_conv(input_split, kernel_origin):
        out_split = np.zeros([output_size, output_size]).tolist()
        for k_row in range(kernel_size):
            for k_col in range(kernel_size):
                for col in range(output_size):
                    for row in range(output_size/2):
                        out_split[row][col] += \
                            kernel_origin[k_row][k_col] *\
                            input_split[stride*row+k_row][stride*col + k_col]

                    for row in range(output_size/2, output_size):
                        out_split[row][col] += \
                            kernel_origin[k_row][k_col] *\
                            input_split[stride*row+k_row][stride*col + k_col]
        print(out_split)

    def __singel_outchannel_conv_c_style__(_input, _kernel, _out_result):
        for channel in range(input_channel):
            __singel_conv_c_style__(
                _input[channel], _kernel[channel], _out_result)
        splite_conv(_input[0], _kernel[0])

    for channel in range(output_channel):
        __singel_outchannel_conv_c_style__(
            input_input, kernel_input[channel], out_result[channel])

    return np.asarray(out_result)


if __name__ == '__main__':
    input = np.zeros([3, 3, 3])
    for chan in range(3):
        for col in range(3):
            for ral in range(3):
                input[chan][col][ral] = chan + col + ral

    # print(input)
    # print(input.shape)

    kernel = np.zeros([3, 3, 2, 2])
    for out_chan in range(3):
        for in_chan in range(3):
            for hight in range(2):
                for width in range(2):
                    kernel[out_chan][in_chan][hight][width] = \
                        out_chan + in_chan + hight + width

    # print(kernel)
    # rs = conv_c_style(input, kernel, stride=1)
    # print(rs)

    singel_rs = conv_c_style_splited(input, kernel, stride=1)
    print(singel_rs)

    # rs_fpga = conv_fpga_format(input, kernel)
    # print(rs_fpga)

    # print(kernel)
    # result = conv(input, kernel, padding='VALID')
    # print(result)
    # print(result.shape)

    # change the input from [3,9,9](channel, kernel_size, kernel_size)
    # to [1,3,9,9](batch_size=1, channel, kernel_size, kernel_size)
    tf_input = np.expand_dims(input, axis=0)
    # change the array shape
    # from [batch_size, channel, kernel_size, kernel_size]
    # to [batch_size, kernel_size, kernel_size, channel]
    tf_input = tf_input.transpose((0, 2, 3, 1))
    # print(tf_input)
    # print(tf_input.shape)
    # change the kernel array shape
    # from [kernel_num, input_channel, kernel_size, kernel_size]
    # to [kernel_size, kernel_size, input_channel, kernel_num]
    tf_kernel = kernel.transpose((2, 3, 1, 0))
    # print(tf_kernel)
    # print(tf_kernel.shape)
    # tensorflow format is [batch, size, size, output_channel]
    tf_result = tfconv(tf_input, tf_kernel, padding='VALID')
    # but numpy format is [output_channel, size, size]
    # so need change the tensorflow output format
    # to [batch, channel, size, size]
    tf_result = tf_result.transpose((0, 3, 1, 2))
    tf_result = np.squeeze(tf_result)
    print(tf_result)
    point_kernel = np.zeros([5, 3, 1, 1])
    for out_chan in range(5):
        for in_chan in range(3):
            for hight in range(1):
                for width in range(1):
                    point_kernel[out_chan][in_chan][hight][width] = \
                        out_chan + in_chan + hight + width

    dw_res = dwconv(input, kernel, point_kernel)
    print(dw_res)

    tf_point_kernel = point_kernel.transpose((2, 3, 1, 0))
    tf_dw_result = tfdwconv(
        tf_input, tf_kernel, tf_point_kernel, padding='VALID')
    tf_dw_result = tf_dw_result.transpose((0, 3, 1, 2))
    tf_dw_result = np.squeeze(tf_dw_result)
    print(tf_dw_result)
