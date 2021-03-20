import 'dart:convert';

const _bnutKey = [
  0x04,
  0x1f,
  0x5a,
  0xac,
  0x5f,
  0x79,
  0x10,
  0xaf,
  0x04,
  0x1d,
  0x46,
  0x3a,
  0x5f,
  0x08,
  0xee,
  0xcb,
  0xb5,
  0x29,
  0x06,
  0x2e,
  0xf9,
  0x4b,
  0xca,
  0x44,
  0x5e,
  0xb3,
  0xac,
  0x81,
  0xaf,
  0x87,
  0x04,
  0x36,
  0x60,
  0xf4,
  0x86,
  0x93,
  0x62,
  0x0d,
  0x77,
  0x6a,
  0xba,
  0x74,
  0x9e,
  0xb3,
  0xd0,
  0xbb,
  0xfa,
  0xd2,
  0x87,
  0x87,
  0x38,
  0x9b,
  0x10,
  0x78,
  0xe2,
  0x11,
  0x7e,
  0xcb,
  0x57,
  0xf1,
  0x18,
  0xbc,
  0x7e,
  0xf1,
  0x71,
  0xac,
  0x38,
  0xc7,
  0x38,
  0x05,
  0x99,
  0xeb,
  0xcf,
  0xe0,
  0xd6,
  0x1b,
  0x9d,
  0x63,
  0xfc,
  0xa2,
  0x23,
  0xeb,
  0x65,
  0x58,
  0xcf,
  0xee,
  0xe9,
  0x68,
  0x93,
  0x9c,
  0xd7,
  0xd4,
  0x33,
  0x4a,
  0xa1,
  0xb8,
  0x61,
  0x8e,
  0x59,
  0x50,
  0x8a,
  0x29,
  0xdf,
  0xba,
  0x6d,
  0xa9,
  0xd6,
  0x7b,
  0x70,
  0xc9,
  0x5b,
  0xc2,
  0xb1,
  0x9e,
  0x74,
  0x6f,
  0xdd,
  0x72,
  0x48,
  0xd1,
  0xc3,
  0x6e,
  0x12,
  0x32,
  0xa7,
  0xfa,
  0xd6,
  0x13,
  0x57,
  0xe4,
  0xd1,
  0x36,
  0xfe,
  0x41,
  0xb1,
  0x5f,
  0xba,
  0x16,
  0x88,
  0xd9,
  0xef,
  0xb5,
  0x7f,
  0xba,
  0x58,
  0xe8,
  0x4d,
  0xe6,
  0xe2,
  0xcf,
  0x66,
  0xd5,
  0x37,
  0x89,
  0xf3,
  0x13,
  0x1c,
  0x94,
  0x84,
  0x8a,
  0x7a,
  0xf3,
  0x86,
  0x81,
  0x3d,
  0x14,
  0x75,
  0x63,
  0xe0,
  0x70,
  0xd1,
  0x3f,
  0xc3,
  0xef,
  0xd1,
  0x13,
  0x42,
  0x10,
  0xd9,
  0xc7,
  0x85,
  0xcb,
  0xac,
  0xfa,
  0x18,
  0x34,
  0x60,
  0x80,
  0x39,
  0xdf,
  0x14,
  0xa6,
  0xf4,
  0x06,
  0x62,
  0x3a,
  0xef,
  0x6b,
  0x96,
  0x4d,
  0x05,
  0xfe,
  0x9b,
  0xb4,
  0x94,
  0x3e,
  0xb9,
  0x53,
  0x95,
  0x5f,
  0xff,
  0x1a,
  0x70,
  0x2f,
  0x80,
  0xca,
  0x8c,
  0xb8,
  0x41,
  0x7f,
  0xa8,
  0xa4,
  0xed,
  0xed,
  0xeb,
  0x63,
  0x4d,
  0x68,
  0xbc,
  0x0e,
  0x79,
  0xa5,
  0x52,
  0x09,
  0xce,
  0x41,
  0x0a,
  0x6b,
  0x9d,
  0x04,
  0x7b,
  0x1d,
  0xa8,
  0xe5,
  0x49,
  0xc2,
  0x4d,
  0xcc,
  0xbc,
  0x5c,
  0x7e,
  0x1a,
  0x0f,
  0xab,
  0x77,
  0xe9,
  0x89,
  0x53,
  0x2e,
  0x13,
  0x4c,
  0xc5,
  0x88,
  0xf3,
  0xef,
  0xd9,
  0x50,
  0xec,
  0xcd,
  0x3d,
  0xe8,
  0xad,
  0x1a,
  0x91,
  0xbb,
  0x31,
  0xba,
  0x4e,
  0x79,
  0x89,
  0xd0,
  0x6a,
  0x00,
  0x58,
  0x18,
  0xbb,
  0x1b,
  0x21,
  0xf4,
  0x1e,
  0xed,
  0x43,
  0x47,
  0x57,
  0x2b,
  0xbf,
  0x04,
  0xb6,
  0x0c,
  0xbf,
  0x85,
  0x7d,
  0xff,
  0xd6,
  0x9c,
  0x04,
  0x21,
  0x07,
  0x69,
  0x99,
  0x6c,
  0x87,
  0xf0,
  0x27,
  0xaf,
  0x41,
  0x69,
  0x9d,
  0x41,
  0x1d,
  0x56,
  0x0c,
  0x73,
  0x00,
  0x55,
  0x8c,
  0xc9,
  0x92,
  0xb9,
  0xe7,
  0xe7,
  0xc1,
  0xda,
  0xf3,
  0x4c,
  0x08,
  0x27,
  0xbe,
  0xc1,
  0x6e,
  0x00,
  0x6b,
  0x8f,
  0x50,
  0x44,
  0xde,
  0x72,
  0xde,
  0xab,
  0x19,
  0x4f,
  0x66,
  0xd5,
  0x64,
  0xa8,
  0x53,
  0x1e,
  0x2e,
  0xca,
  0xf2,
  0x36,
  0xb5,
  0xcc,
  0xfa,
  0x73,
  0x67,
  0x37,
  0xc9,
  0xe4,
  0x06,
  0x84,
  0x6e,
  0x25,
  0x8e,
  0x49,
  0x6a,
  0xf4,
  0xd5,
  0x31,
  0x36,
  0x87,
  0xf7,
  0xb0,
  0x82,
  0x9a,
  0x6e,
  0x72,
  0x42,
  0x4a,
  0x03,
  0x97,
  0x69,
  0xa3,
  0x68,
  0xa0,
  0x72,
  0xfa,
  0xa0,
  0x27,
  0xa3,
  0xfb,
  0x25,
  0x51,
  0x0f,
  0x81,
  0xc8,
  0x02,
  0x5f,
  0x28,
  0x55,
  0xd5,
  0x50,
  0xa3,
  0xfe,
  0xc9,
  0xfb,
  0xcd,
  0x74,
  0xbc,
  0xd7,
  0x80,
  0xd4,
  0x98,
  0x7e,
  0x28,
  0x47,
  0x4d,
  0x32,
  0x16,
  0x67,
  0x84,
  0x1d,
  0x94,
  0x63,
  0x10,
  0x5a,
  0xbc,
  0xe1,
  0x23,
  0xb7,
  0x08,
  0xa6,
  0x45,
  0x36,
  0xa8,
  0xf7,
  0x05,
  0x58,
  0x96,
  0xbc,
  0x6b,
  0x19,
  0x6a,
  0x68,
  0x33,
  0xba,
  0xed,
  0x9b,
  0xbb,
  0x40,
  0x6e,
  0x84,
  0xb7,
  0xbf,
  0xd7,
  0x07,
  0xaa,
  0x56,
  0x7e,
  0xa3,
  0x14,
  0xf8,
  0xbc,
  0x10,
  0x6a,
  0xf0,
  0x3e,
  0xa9,
  0xc9,
  0x21,
  0x1d,
  0x8f,
  0x69,
  0x10,
  0xae,
  0x89,
  0xd2,
  0xa3,
  0x1a,
  0xac,
  0xd1,
  0xa6,
  0xac,
  0xbf,
  0x27,
  0x11,
  0xec,
  0x5b,
  0x06,
  0x0a,
  0x6f,
  0xd4,
  0x3c,
  0xac,
  0x6c,
  0xda,
  0x2b,
  0x84,
  0x0d,
  0xdd,
  0x7f,
  0xdf,
  0x8a,
  0x34,
  0x9e,
  0xc5,
  0xf6,
  0xfd,
  0xdd,
  0xc3,
  0xd6,
  0xc1,
  0x77,
  0x6b,
  0x76,
  0xdf,
  0x3d,
  0x9b,
  0xfb,
  0xa5,
  0x0d,
  0x81,
  0x37,
  0x3c,
  0x03,
  0x59,
  0x3f,
  0x4c,
  0x71,
  0xfc,
  0xbd,
  0x5b,
  0x8f,
  0x18,
  0x05,
  0xf4,
  0xf1,
  0x3e,
  0xe8,
  0x8c,
  0xbb,
  0xa0,
  0x4b,
  0x24,
  0x96,
  0x97,
  0x76,
  0xac,
  0x60,
  0xe6,
  0x2c,
  0x2d,
  0xa6,
  0xc0,
  0x7e,
  0xa5,
  0xd2,
  0x89,
  0x5f,
  0xb0,
  0x23,
  0x5e,
  0xf6,
  0xeb,
  0x5f,
  0x56,
  0xb6,
  0x17,
  0x4a,
  0x85,
  0x2e,
  0xff,
  0xd5,
  0xc4,
  0x9f,
  0x1a,
  0x15,
  0x32,
  0x52,
  0xf0,
  0xf9,
  0x79,
  0xa7,
  0x3c,
  0xba,
  0xd0,
  0xec,
  0xd5,
  0x10,
  0xc3,
  0xf2,
  0x4c,
  0x29,
  0xb4,
  0x60,
  0x54,
  0x5a,
  0x20,
  0xc4,
  0xe5,
  0x92,
  0xa1,
  0x6e,
  0x1e,
  0x92,
  0xb7,
  0xfc,
  0xee,
  0xdd,
  0x45,
  0xb3,
  0x71,
  0x6f,
  0xdc,
  0x94,
  0x1a,
  0x30,
  0xba,
  0x29,
  0x95,
  0x26,
  0x90,
  0x22,
  0x69,
  0x6c,
  0x06,
  0xa2,
  0x5f,
  0xe6,
  0xfe,
  0x59,
  0xa5,
  0xb0,
  0x9a,
  0x51,
  0xb1,
  0x5a,
  0xff,
  0x88,
  0xe6,
  0xd5,
  0xd7,
  0x42,
  0xf8,
  0x2a,
  0x97,
  0x1a,
  0x0f,
  0xf0,
  0x85,
  0xdc,
  0xac,
  0x7b,
  0x76,
  0x15,
  0x4e,
  0xd4,
  0x5a,
  0x66,
  0xd4,
  0x6b,
  0x78,
  0x9c,
  0xa0,
  0x8d,
  0x79,
  0x7f,
  0x7f,
  0x96,
  0x26,
  0x6d,
  0x4b,
  0xe5,
  0xf0,
  0xa5,
  0x4c,
  0x93,
  0x33,
  0x63,
  0x62,
  0xe3,
  0x38,
  0xaf,
  0xe4,
  0x77,
  0xff,
  0xf4,
  0x45,
  0x47,
  0xb9,
  0x53,
  0x7a,
  0x51,
  0x17,
  0xb4,
  0x1e,
  0x10,
  0x44,
  0xa1,
  0x51,
  0xad,
  0xb2,
  0xd1,
  0x64,
  0xf6,
  0x98,
  0x85,
  0x37,
  0x12,
  0x36,
  0x95,
  0x5c,
  0xf0,
  0xde,
  0x49,
  0x02,
  0x83,
  0xb2,
  0xe8,
  0x94,
  0xb0,
  0x2c,
  0x10,
  0x1a,
  0x01,
  0x61,
  0xcb,
  0x66,
  0x21,
  0x05,
  0x5d,
  0xef,
  0x08,
  0x2d,
  0xdd,
  0x7b,
  0xf0,
  0xd7,
  0x8a,
  0x7e,
  0x0e,
  0x2a,
  0xda,
  0x45,
  0x00,
  0x7c,
  0x51,
  0xd1,
  0x07,
  0x17,
  0x17,
  0x83,
  0xf4,
  0xba,
  0x47,
  0x7c,
  0xe3,
  0xe0,
  0x07,
  0xc1,
  0xa9,
  0xc3,
  0x5c,
  0x21,
  0x0e,
  0x1f,
  0xb9,
  0xd6,
  0xba,
  0xb6,
  0x5c,
  0xec,
  0xef,
  0x96,
  0x58,
  0x64,
  0xfa,
  0x1c,
  0x71,
  0x17,
  0x6a,
  0xb6,
  0xaa,
  0x5b,
  0xfd,
  0x6b,
  0x9e,
  0x67,
  0x5e,
  0x1b,
  0x92,
  0x77,
  0x90,
  0x86,
  0x45,
  0xae,
  0x27,
  0x0e,
  0x8e,
  0xbd,
  0x3c,
  0x3b,
  0xa3,
  0x47,
  0x1d,
  0x02,
  0x38,
  0x02,
  0xc7,
  0xc4,
  0x4f,
  0x9d,
  0x14,
  0x17,
  0xc9,
  0x64,
  0xb3,
  0x47,
  0xbf,
  0xa5,
  0xda,
  0x9b,
  0x92,
  0xcf,
  0xbd,
  0x57,
  0xc2,
  0x5e,
  0xbc,
  0x83,
  0x82,
  0x7a,
  0x5f,
  0x70,
  0x07,
  0x58,
  0x02,
  0xf6,
  0xa3,
  0x67,
  0x4e,
  0x7e,
  0x94,
  0x2b,
  0x6e,
  0xc3,
  0x9c,
  0xe6,
  0xfd,
  0x57,
  0x50,
  0xfb,
  0xc0,
  0xe6,
  0x30,
  0x12,
  0x18,
  0x3c,
  0x7a,
  0xfb,
  0x35,
  0x07,
  0xbe,
  0x53,
  0x0a,
  0x5c,
  0x2f,
  0xe7,
  0x03,
  0xfb,
  0xbf,
  0xda,
  0x78,
  0x51,
  0xe9,
  0x88,
  0xdf,
  0x41,
  0x4b,
  0x28,
  0xc3,
  0xa1,
  0xfa,
  0x34,
  0x77,
  0x86,
  0x94,
  0x88,
  0x8a,
  0x3f,
  0x15,
  0x4b,
  0xf9,
  0x21,
  0x69,
  0x90,
  0x26,
  0x07,
  0xc5,
  0xbb,
  0x8a,
  0x97,
  0xb5,
  0xa4,
  0x2c,
  0x46,
  0xf4,
  0x7d,
  0xcf,
  0x19,
  0xfe,
  0x73,
  0xee,
  0x2f,
  0x65,
  0x16,
  0x68,
  0x01,
  0xe6,
  0x78,
  0xfa,
  0x67,
  0x3b,
  0x17,
  0x70,
  0x59,
  0xad,
  0x7b,
  0x9a,
  0x7a,
  0x70,
  0x9d,
  0xfe,
  0x54,
  0xad,
  0x0d,
  0x52,
  0x63,
  0x5e,
  0xd2,
  0xa7,
  0xd3,
  0xdd,
  0x0f,
  0x65,
  0x08,
  0x3a,
  0x6a,
  0xfa,
  0xe1,
  0x4e,
  0x2c,
  0x51,
  0xbc,
  0x93,
  0x26,
  0x03,
  0x37,
  0xb1,
  0x5a,
  0x4e,
  0xbb,
  0xd7,
  0x55,
  0xc8,
  0xb9,
  0xcf,
  0x5d,
  0xd3,
  0xb2,
  0xcf,
  0x4e,
  0xcf,
  0xf7,
  0x0f,
  0x43,
  0x11,
  0x34,
  0x1f,
  0xf7,
  0x96,
  0xae,
  0xf4,
  0xe9,
  0x76,
  0x46,
  0xc7,
  0x42,
  0x19,
  0x44,
  0x9d,
  0x75,
  0x2b,
  0xd4,
  0xa4,
  0xaa,
  0x50,
  0x4f,
  0x43,
  0xdb,
  0x96,
  0x3a,
  0xef,
  0xba,
  0xae,
  0x0e,
  0xbe,
  0x59,
  0xd9,
  0xbc,
  0xbd,
  0x87,
  0xa3,
  0xee,
  0x00,
  0xfa,
  0x51,
  0x0d,
  0x7d,
  0x31,
  0x1a,
  0x07,
  0x98,
  0x16,
  0x18,
  0xcc,
  0x7d,
  0x65,
  0xfc,
  0x9c,
  0x31,
  0xd0,
  0x84,
  0x03,
  0x66,
  0xde,
  0xac,
  0x9f,
  0x11,
  0x96,
  0xa6,
  0xa6,
  0xbc,
  0xe0,
  0x89,
  0x2a,
  0x9a,
  0xa5,
  0xcb,
  0x1a,
  0x5f,
  0xbb,
  0x70,
  0x07,
  0xcc,
  0x83,
  0xfe,
  0xab,
  0x0c,
  0x4e,
  0x37,
  0x2a,
  0xc1,
  0x83,
  0x84,
  0x15,
  0xdc,
  0x81,
  0x32,
  0x32,
  0x2f,
  0x45,
  0x5f,
  0xfc,
  0xc3,
  0xca,
  0xb1,
  0xeb,
  0xea,
  0x33,
  0xcc,
  0x74,
  0x13,
  0xa9,
  0x80,
  0xce,
  0x60,
  0x05,
  0xc4,
  0x7a,
  0xf7,
  0x2d,
  0x66,
  0x80,
  0x1b,
  0x3d,
  0x7f,
  0x78,
  0xf9,
  0x6d,
  0xa7,
  0x4f,
  0x42,
  0xac,
  0xec,
  0xc5,
  0x7c,
  0x0e,
  0x82,
  0xb8,
  0x18,
  0xec,
  0x3a,
  0x23,
  0x42,
  0xc3,
  0xb4,
  0xe4,
  0x7b,
  0xe3,
  0x53,
  0x3f,
  0xe7,
  0xc9,
  0xf3,
  0x26,
  0x66,
  0x46,
  0x5c,
  0x35,
  0x64,
  0x67,
  0x74,
  0x7e,
  0x70,
  0x14,
  0x36,
  0x09,
  0x8e,
  0x74,
  0x65,
  0x19,
  0x4b,
  0x17,
  0x00,
  0x2f,
  0x94,
  0xd1,
  0x73,
  0xcf,
  0x46,
  0x66,
  0x92,
  0x04,
  0x85,
  0xeb,
  0x46,
  0xa4,
  0xcc,
  0xe6,
  0x03,
  0x53,
  0xc7,
  0x3a,
  0x00,
  0x48,
  0xe3,
  0xc4,
  0x24,
  0xd1,
  0xa1,
  0xc4,
  0xc1,
  0x96,
  0xad,
  0xfd,
  0x03,
  0xa0,
  0xb2,
  0x9a,
  0x26,
  0x19,
  0xea,
  0xd6,
  0x6a,
  0xd0,
  0x77,
  0x5a,
  0xc6,
  0x82,
  0x74,
  0x64,
  0x5d,
  0xda,
  0xc9,
  0xac,
  0xb3,
  0x33,
  0xc1,
  0x06,
  0x9f,
  0x23,
  0x5c,
  0xc5,
  0xff,
  0xb8,
  0x65,
  0xe5,
  0x2d,
  0x7f,
  0x42,
  0xe7,
  0x34,
  0x48,
  0x8d,
  0x7b,
  0xc2,
  0xab,
  0x66,
  0xdf,
  0xdb,
  0x49,
  0x85,
  0x09,
  0x51,
  0xd2,
  0x11,
  0x86,
  0xf6,
  0xc9,
  0x33,
  0x1f,
  0x8e,
  0x09,
  0x69,
  0x41,
  0x86,
  0x06,
  0x9a,
  0x19,
  0x66,
  0xd3,
  0xed,
  0x80,
  0x06,
  0xe6,
  0x58,
  0x9c,
  0x82,
  0x9d,
  0xfa,
  0x42,
  0xee,
  0x80,
  0x29,
  0x1d,
  0xc8,
  0x43,
  0x49,
  0x8f,
  0x31,
  0x91,
  0x61,
  0x5a,
  0xda,
  0x8a,
  0x6e,
  0xfd,
  0xbf,
  0x07,
  0x76,
  0xdf,
  0x95,
  0xa4,
  0x5b,
  0x2d,
  0x03,
  0x7b,
  0x74,
  0x82,
  0x93,
  0xaf,
  0xdb,
  0x4b,
  0x66,
  0xae,
  0x86,
  0xe7,
  0xa9,
  0x36,
  0x17,
  0x91,
  0xcb,
  0x13,
  0x74,
  0xfd,
  0x6a,
  0xae,
  0x15,
  0xc4,
  0x11,
  0x46,
  0x1f,
  0x7f,
  0xa2,
  0xfa,
  0x34,
  0xb5,
  0x94,
  0x8d,
  0x07,
  0x75,
  0xdc,
  0xe8,
  0xb1,
  0xc1,
  0xac,
  0x5e,
  0xc5,
  0xb0,
  0xdd,
  0xb1,
  0x25,
  0x52,
  0x2c,
  0xd8,
  0x92,
  0x51,
  0x27,
  0x7d,
  0x04,
  0x5c,
  0xe4,
  0x48,
  0xbe,
  0x43,
  0x76,
  0xdd,
  0x20,
  0xe1,
  0x20,
  0xa5,
  0x3a,
  0xbc,
  0x46,
  0x4f,
  0x24,
  0x6d,
  0x27,
  0x15,
  0x0f,
  0xc0,
  0x4b,
  0xbe,
  0x19,
  0x9a,
  0xbd,
  0x66,
  0xe4,
  0x9e,
  0xf8,
  0x00,
  0xe4,
  0x8e,
  0xa1,
  0x96,
  0x7b,
  0x71,
  0xf9,
  0x56,
  0xc6,
  0x78,
  0x0f,
  0x4c,
  0x35,
  0xa0,
  0xb8,
  0xef,
  0xdb,
  0x17,
  0x3f,
  0x5c,
  0x8a,
  0x5e,
  0xdc,
  0x64,
  0x9c,
  0x33,
  0xe5,
  0x47,
  0x92,
  0x2b,
  0xc5,
  0x3d,
  0x5e,
  0x21,
  0xaf,
  0xb9,
  0x7f,
  0x52,
  0x11,
  0x6b,
  0xd0,
  0x43,
  0xca,
  0x09,
  0x20,
  0x69,
  0x1b,
  0xcd,
  0x80,
  0x86,
  0x5d,
  0xbc,
  0x5f,
  0xd3,
  0x77,
  0xac,
  0x57,
  0xe3,
  0x0c,
  0x02,
  0xc3,
  0x41,
  0x77,
  0x3e,
  0x18,
  0xde,
  0x77,
  0x38,
  0xf0,
  0x2d,
  0xa9,
  0x26,
  0xe5,
  0x0a,
  0xb8,
  0x64,
  0x22,
  0x5e,
  0x56,
  0xf2,
  0xba,
  0x83,
  0xe9,
  0xbc,
  0xb6,
  0x67,
  0x04,
  0x9c,
  0xf0,
  0x72,
  0x9b,
  0x1f,
  0xa1,
  0x28,
  0xf5,
  0x0a,
  0xbb,
  0x8d,
  0x60,
  0x9b,
  0xf7,
  0x4b,
  0xa6,
  0x8e,
  0xac,
  0x95,
  0x42,
  0xe5,
  0x65,
  0xc8,
  0x51,
  0x67,
  0x30,
  0xd6,
  0x4a,
  0xe4,
  0xb7,
  0x62,
  0x6c,
  0x3e,
  0x10,
  0xaa,
  0xfa,
  0x27,
  0x53,
  0x27,
  0x28,
  0xa9,
  0xef,
  0xf6,
  0xd2,
  0x6a,
  0xbc,
  0xf4,
  0xf2,
  0xac,
  0xcf,
  0xab,
  0xcf,
  0x15,
  0x10,
  0xef,
  0xf5,
  0x33,
  0x8c,
  0x46,
  0xe8,
  0xbc,
  0x8a,
  0x0b,
  0x96,
  0x99,
  0x5f,
  0x51,
  0x90,
  0xa0,
  0x01,
  0x87,
  0xf7,
  0x24,
  0x5c,
  0xe0,
  0x36,
  0x2d,
  0x67,
  0x70,
  0x75,
  0x86,
  0xf4,
  0x15,
  0xc8,
  0x7b,
  0x4b,
  0x1a,
  0x2a,
  0x5e,
  0x74,
  0x9c,
  0x2c,
  0xcd,
  0x57,
  0xab,
  0x6b,
  0xb5,
  0x85,
  0x2f,
  0xc5,
  0x14,
  0xd2,
  0x90,
  0x4a,
  0x81,
  0xaa,
  0x14,
  0xf4,
  0x6d,
  0x20,
  0x06,
  0x16,
  0x26,
  0xc5,
  0x9a,
  0x94,
  0x9e,
  0x3d,
  0x92,
  0xd6,
  0xf0,
  0x92,
  0xa0,
  0x7d,
  0x9d,
  0x46,
  0x89,
  0xd2,
  0x9a,
  0x2a,
  0x0e,
  0x02,
  0x0a,
  0xf0,
  0x8a,
  0x0a,
  0xca,
  0x81,
  0x59,
  0x73,
  0xb0,
  0x0e,
  0xff,
  0xbd,
  0x92,
  0xe8,
  0x04,
  0x9b,
  0x08,
  0x10,
  0x9f,
  0xe4,
  0xf1,
  0x8c,
  0x19,
  0x43,
  0xb6,
  0x7f,
  0xef,
  0xb4,
  0x50,
  0xf5,
  0xb4,
  0xae,
  0x0a,
  0x81,
  0xbc,
  0x1f,
  0x06,
  0x89,
  0x79,
  0x1b,
  0x80,
  0x5b,
  0xa2,
  0x53,
  0xd4,
  0x06,
  0x18,
  0x46,
  0x41,
  0xea,
  0x89,
  0x39,
  0x6a,
  0x0b,
  0xd0,
  0xe7,
  0x9f,
  0x29,
  0x22,
  0xf8,
  0xe0,
  0x90,
  0xea,
  0x32,
  0x9d,
  0xaf,
  0x6f,
  0x70,
  0x3d,
  0x69,
  0x3a,
  0x55,
  0x64,
  0x2e,
  0x38,
  0xbf,
  0xf4,
  0xc8,
  0xa1,
  0xfd,
  0xcf,
  0xf5,
  0x97,
  0xbf,
  0x61,
  0xb8,
  0x8d,
  0xd1,
  0xe1,
  0x6e,
  0x6d,
  0x86,
  0x51,
  0xa2,
  0x77,
  0xf5,
  0x49,
  0xa0,
  0xea,
  0xe5,
  0x77,
  0xcb,
  0x64,
  0x88,
  0xe5,
  0xae,
  0x09,
  0xea,
  0xf8,
  0xd4,
  0x65,
  0x27,
  0x3c,
  0x57,
  0x12,
  0x5e,
  0xe0,
  0x39,
  0x18,
  0x68,
  0x02,
  0x74,
  0x16,
  0x47,
  0xab,
  0xd3,
  0x25,
  0x5f,
  0x98,
  0x7e,
  0x76,
  0x67,
  0xbd,
  0x56,
  0xc1,
  0x1d,
  0x89,
  0x05,
  0x5d,
  0xbb,
  0xea,
  0xd3,
  0x2e,
  0x2c,
  0x0e,
  0x39,
  0x41,
  0xfd,
  0xee,
  0x37,
  0x38,
  0x14,
  0x8b,
  0x65,
  0x66,
  0x22,
  0xf6,
  0xca,
  0xb9,
  0xd9,
  0x11,
  0x6f,
  0x5b,
  0xdd,
  0x16,
  0xb1,
  0x17,
  0x7b,
  0xda,
  0x59,
  0x7b,
  0x1b,
  0xd0,
  0x6d,
  0xc1,
  0x74,
  0xcf,
  0xc3,
  0x6e,
  0x84,
  0x94,
  0x5a,
  0xb6,
  0x3e,
  0x05,
  0x67,
  0xa5,
  0x00,
  0x3a,
  0x31,
  0xfe,
  0xcb,
  0x3c,
  0x9c,
  0xe1,
  0x30,
  0x8a,
  0x86,
  0x2e,
  0x0a,
  0x5f,
  0xd4,
  0xac,
  0xf1,
  0xb4,
  0x4a,
  0xe9,
  0x69,
  0x06,
  0x1e,
  0xde,
  0xdc,
  0xd8,
  0x4a,
  0x59,
  0x4d,
  0xf7,
  0xa4,
  0x1a,
  0xc8,
  0x80,
  0xae,
  0xba,
  0x9b,
  0xa1,
  0x2d,
  0x4f,
  0x47,
  0x21,
  0x7b,
  0xd0,
  0x33,
  0xa0,
  0x9c,
  0x38,
  0x25,
  0x9d,
  0x12,
  0x6c,
  0x70,
  0x3c,
  0x70,
  0xdc,
  0xed,
  0xc4,
  0xaf,
  0xeb,
  0xaa,
  0xe9,
  0x42,
  0x0e,
  0x63,
  0xce,
  0xea,
  0xb6,
  0xb4,
  0xc8,
  0x4a,
  0xee,
  0x0a,
  0xe3,
  0x3a,
  0xc3,
  0x5e,
  0x25,
  0xdb,
  0x66,
  0xa0,
  0x94,
  0x6d,
  0x13,
  0xf3,
  0xf7,
  0xe2,
  0xae,
  0x9d,
  0x5f,
  0x31,
  0x32,
  0xbc,
  0x64,
  0x6a,
  0xc9,
  0xb8,
  0x2e,
  0x8e,
  0xba,
  0x7b,
  0x3a,
  0x1b,
  0x06,
  0x62,
  0xd8,
  0x69,
  0xd0,
  0xf1,
  0x76,
  0xb7,
  0x7f,
  0x49,
  0x9f,
  0x03,
  0xa5,
  0x5a,
  0xc1,
  0x9c,
  0x9d,
  0xd6,
  0xb1,
  0x77,
  0xf6,
  0xeb,
  0xee,
  0x45,
  0x93,
  0xb0,
  0xa7,
  0x40,
  0x8d,
  0x5b,
  0x7e,
  0xc8,
  0xde,
  0x37,
  0x09,
  0xb1,
  0xbe,
  0x57,
  0x1c,
  0x59,
  0xcb,
  0x09,
  0xc8,
  0x7b,
  0xeb,
  0x0b,
  0x21,
  0xc6,
  0xf1,
  0x80,
  0xc2,
  0x2b,
  0x01,
  0xa0,
  0x11,
  0xf9,
  0xb3,
  0x32,
  0x42,
  0xa9,
  0xf8,
  0xb9,
  0x1c,
  0x79,
  0xbf,
  0x70,
  0x7d,
  0xba,
  0x56,
  0xf5,
  0x9e,
  0xe9,
  0x92,
  0xc7,
  0x16,
  0x7f,
  0xad,
  0x71,
  0x9f,
  0x87,
  0xf1,
  0x82,
  0x9b,
  0xf4,
  0x19,
  0x43,
  0x54,
  0xaf,
  0x71,
  0x26,
  0x05,
  0x71,
  0xc3,
  0xff,
  0x9c,
  0x56,
  0xf1,
  0xf5,
  0x3c,
  0x2c,
  0x60,
  0x36,
  0x84,
  0x8f,
  0x1b,
  0x6c,
  0x91,
  0xb6,
  0xb3,
  0xf2,
  0xc3,
  0x09,
  0xe6,
  0xc5,
  0x42,
  0x79,
  0x06,
  0x3b,
  0x3f,
  0x8f,
  0x17,
  0x75,
  0xfa,
  0x40,
  0xb5,
  0x95,
  0x86,
  0x87,
  0xbb,
  0xaf,
  0x4e,
  0xb0,
  0xa4,
  0x7f,
  0x56,
  0x73,
  0xaf,
  0xdf,
  0x41,
  0xc7,
  0xc4,
  0xf6,
  0x16,
  0x73,
  0x18,
  0x30,
  0xc1,
  0x64,
  0x92,
  0xf0,
  0x5a,
  0xc1,
  0xeb,
  0x06,
  0x28,
  0xbf,
  0x97,
  0xe2,
  0x63,
  0x33,
  0x66,
  0x85,
  0xbc,
  0xec,
  0xe9,
  0x3a,
  0x9c,
  0xbd,
  0x95,
  0x08,
  0x2f,
  0x5c,
  0xa9,
  0xe5,
  0x1e,
  0xed,
  0xcf,
  0xab,
  0x1f,
  0x5b,
  0x83,
  0xcb,
  0x2e,
  0x6d,
  0x36,
  0xc2,
  0x97,
  0x93,
  0x31,
  0x4e,
  0xba,
  0x84,
  0x3a,
  0x5f,
  0x8c,
  0x88,
  0xf8,
  0xcf,
  0xdf,
  0x95,
  0x16,
  0xd0,
  0x61,
  0x1b,
  0x29,
  0x28,
  0x65,
  0x9e,
  0x52,
  0x1f,
  0x64,
  0x08,
  0xa2,
  0x33,
  0x41,
  0xbb,
  0x3f,
  0x90,
  0x4f,
  0x67,
  0x4a,
  0x42,
  0x13,
  0xa1,
  0x7f,
  0x26,
  0xc8,
  0x2e,
  0x99,
  0xa4,
  0xa6,
  0x23,
  0x7a,
  0x1f,
  0xe1,
  0xad,
  0x0e,
  0x27,
  0x72,
  0xb0,
  0xea,
  0x73,
  0x98,
  0x11,
  0xb6,
  0x90,
  0x1d,
  0xd2,
  0x50,
  0x59,
  0x58,
  0xe2,
  0xac,
  0x25,
  0xf6,
  0xb1,
  0x7c,
  0xc2,
  0x77,
  0x85,
  0x93,
  0x24,
  0x78,
  0x8e,
  0x09,
  0xdb,
  0xb6,
  0xbb,
  0x1d,
  0x49,
  0xce,
  0x49,
  0xde,
  0x90,
  0xc4,
  0x1f,
  0x88,
  0x4c,
  0x49,
  0xdc,
  0xaf,
  0x04,
  0xbb,
  0xac,
  0x1c,
  0x60,
  0xeb,
  0xdd,
  0x7a,
  0x1a,
  0xa1,
  0x35,
  0xaf,
  0xb5,
  0xe0,
  0x00,
  0x0a,
  0xef,
  0xe8,
  0xeb,
  0x21,
  0xf6,
  0xff,
  0x93,
  0x77,
  0x5d,
  0xef,
  0xdb,
  0xe0,
  0xcc,
  0x4d,
  0x00,
  0xa4,
  0x79,
  0x7f,
  0x6d,
  0x65,
  0x5a,
  0x7a,
  0x4e,
  0xc0,
  0x16,
  0x4e,
  0xe6,
  0xb5,
  0xbf,
  0x63,
  0xa0,
  0xc6,
  0x40,
  0x80,
  0xe6,
  0xe0,
  0x97,
  0x8f,
  0xb4,
  0xfd,
  0xc2,
  0x21,
  0xeb,
  0x86,
  0x7a,
  0xb2,
  0x65,
  0x78,
  0xa1,
  0xac,
  0xcc,
  0x4d,
  0x7b,
  0x2c,
  0x2a,
  0x97,
  0x9f,
  0x87,
  0x3f,
  0x6c,
  0xaa,
  0x8a,
  0x95,
  0x85,
  0xb9,
  0x84,
  0x54,
  0x24,
  0x93,
  0x04,
  0xd5,
  0xb8,
  0xa8,
  0x62,
  0xf8,
  0x41,
  0xbd,
  0xfe,
  0x35,
  0x73,
  0x64,
  0x4a,
  0x73,
  0x9d,
  0x2c,
  0x88,
  0x9a,
  0x47,
  0x9c,
  0x53,
  0xea,
  0x9d,
  0xdf,
  0xde,
  0x09,
  0x8e,
  0x3f,
  0xfe,
  0xdd,
  0xb2,
  0x53,
  0xe8,
  0x1f,
  0xef,
  0xf7,
  0xba,
  0xaa,
  0xda,
  0xfe,
  0xbb,
  0x96,
  0xdd,
  0xa8,
  0x61,
  0x08,
  0x1c,
  0xd5,
  0x16,
  0xc7,
  0x18,
  0xf6,
  0xb9,
  0x8d,
  0x10,
  0xc6,
  0xe6,
  0x22,
  0x2a,
  0xbc,
  0xf5,
  0x29,
  0x55,
  0x3e,
  0xc2,
  0xb8,
  0xeb,
  0x96,
  0x32,
  0xa9,
  0x18,
  0xa4,
  0x70,
  0xb2,
  0xfd,
  0x58,
  0xfa,
  0x35,
  0x94,
  0xdc,
  0x5e,
  0xd7,
  0x51,
  0x94,
  0xc4,
  0xd2,
  0x8c,
  0xc6,
  0x2a,
  0x0a,
  0xa1,
  0x18,
  0x71,
  0xe0,
  0xd3,
  0xbd,
  0x1b,
  0xc9,
  0xf3,
  0x6d,
  0xd0,
  0x9d,
  0xc5,
  0x18,
  0xa5,
  0xaf,
  0x1d,
  0x59,
  0x1b,
  0xa0,
  0xcb,
  0xac,
  0xe9,
  0xf3,
  0x3b,
  0x5e,
  0x79,
  0x5f,
  0xda,
  0x47,
  0x32,
  0xe7,
  0x3a,
  0x39,
  0x7a,
  0xaa,
  0xf5,
  0x37,
  0x79,
  0x7a,
  0x51,
  0x65,
  0x9e,
  0x2e,
  0xa6,
  0xc1,
  0xe2,
  0xb6,
  0x82,
  0x95,
  0xce,
  0xf3,
  0x89,
  0xaa,
  0x3d,
  0x43,
  0x1e,
  0x3d,
  0xe1,
  0xdd,
  0xc2,
  0xb2,
  0x87,
  0xe2,
  0x3e,
  0x0a,
  0x19,
  0x2f,
  0x82,
  0x14,
  0x66,
  0xf3,
  0x4b,
  0x65,
  0xa3,
  0x03,
  0x86,
  0x08,
  0xb0,
  0xef,
  0x77,
  0xf4,
  0x1a,
  0xd4,
  0x98,
  0x41,
  0xe4,
  0xef,
  0x41,
  0x19,
  0x05,
  0xf5,
  0x0c,
  0x6e,
  0xaf,
  0x23,
  0xf5,
  0x70,
  0x54,
  0x17,
  0x43,
  0xbd,
  0x69,
  0x5c,
  0x29,
  0x55,
  0xe7,
  0xc6,
  0x2b,
  0x54,
  0x96,
  0x83,
  0x42,
  0x5d,
  0x08,
  0xec,
  0xbe,
  0xd6,
  0x65,
  0x1f,
  0xed,
  0xd8,
  0xec,
  0x4d,
  0x7f,
  0xe4,
  0x34,
  0xd2,
  0xa6,
  0x56,
  0x35,
  0x09,
  0x00,
  0x99,
  0x0a,
  0xdd,
  0x35,
  0x1e,
  0x73,
  0x1e,
  0x5e,
  0x0d,
  0x1b,
  0x98,
  0x2c,
  0xb8,
  0x9e,
  0xe3,
  0xc3,
  0xd3,
  0x48,
  0xfa,
  0x6a,
  0x65,
  0x9e,
  0x8e,
  0xe4,
  0x7b,
  0x9d,
  0x17,
  0x9a,
  0xa1,
  0xc3,
  0xaf,
  0x81,
  0x11,
  0xd1,
  0x9d,
  0xb5,
  0xa8,
  0x4d,
  0xb2,
  0xe7,
  0x9c,
  0xca,
  0x57,
  0x7c,
  0xee,
  0xe6,
  0x61,
  0x71,
  0xa0,
  0x16,
  0xaa,
  0xff,
  0xa5,
  0x23,
  0x60,
  0x02,
  0x9c,
  0x72,
  0x1a,
  0x19,
  0x3b,
  0x07,
  0xaf,
  0x8d,
  0x8c,
  0x47,
  0xc6,
  0xf2,
  0xda,
  0x7f,
  0x2c,
  0x8e,
  0x68,
  0x28,
  0xe8,
  0x7b,
  0xe6,
  0xe7,
  0x0e,
  0x8e,
  0xa3,
  0x55,
  0x56,
  0xf5,
  0x82,
  0x83,
  0x6b,
  0xa2,
  0xae,
  0x3b,
  0x03,
  0x6b,
  0x0c,
  0x07,
  0xb3,
  0xed,
  0x73,
  0xf2,
  0x7f,
  0x33,
  0x9c,
  0x10,
  0x32,
  0x1a,
  0xda,
  0xbe,
  0x73,
  0x71,
  0x89,
  0xa9,
  0x92,
  0xe2,
  0x47,
  0x8f,
  0x26,
  0x94,
  0xe4,
  0xc7,
  0x57,
  0x8c,
  0x19,
  0x81,
  0xfa,
  0xd7,
  0xfb,
  0xcd,
  0x61,
  0x68,
  0x2d,
  0x5c,
  0xef,
  0xc1,
  0xd7,
  0x08,
  0x6e,
  0x53,
  0x59,
  0x15,
  0x1f,
  0xa6,
  0xbe,
  0x34,
  0x95,
  0x37,
  0xf2,
  0x4b,
  0x41,
  0x23,
  0xb2,
  0xf6,
  0xcc,
  0x88,
  0x46,
  0xcb,
  0x27,
  0xa6,
  0xf0,
  0x60,
  0x63,
  0xc8,
  0x22,
  0x0c,
  0x40,
  0xe4,
  0x72,
  0x70,
  0x86,
  0x03,
  0x4e,
  0xb4,
  0x16,
  0x61,
  0x6e,
  0x90,
  0xbf,
  0x53,
  0x0c,
  0x11,
  0xd1,
  0xec,
  0xd5,
  0x18,
  0x72,
  0x5d,
  0x9c,
  0xa1,
  0xb2,
  0x1f,
  0xd4,
  0xc8,
  0x5f,
  0xd2,
  0xbb,
  0x8a,
  0x98,
  0xe3,
  0x56,
  0x4e,
  0x23,
  0xf0,
  0x20,
  0x23,
  0x7f,
  0xeb,
  0x80,
  0xc6,
  0xb8,
  0xff,
  0xfd,
  0x69,
  0xfc,
  0x34,
  0x33,
  0x35,
  0xf0,
  0xd4,
  0x84,
  0x8b,
  0xc3,
  0x8c,
  0x8e,
  0x0d,
  0xfe,
  0x51,
  0x60,
  0x5f,
  0x21,
  0x08,
  0x6a,
  0xac,
  0xee,
  0xe3,
  0x37,
  0xea,
  0x82,
  0x8b,
  0xdc,
  0xdd,
  0x27,
  0x02,
  0x2f,
  0xdc,
  0xeb,
  0x46,
  0xb7,
  0x55,
  0xf0,
  0xb5,
  0x65,
  0x11,
  0x81,
  0x33,
  0x07,
  0x37,
  0xe8,
  0x0b,
  0x77,
  0x11,
  0x01,
  0x98,
  0x97,
  0x91,
  0x8d,
  0xa3,
  0xfc,
  0x91,
  0x46,
  0x8b,
  0x6b,
  0xdd,
  0xb6,
  0x26,
  0x07,
  0xf1,
  0xc7,
  0x68,
  0x47,
  0x81,
  0x19,
  0xc7,
  0xa8,
  0xbc,
  0x16,
  0x5c,
  0x26,
  0x4f,
  0xc5,
  0xca,
  0x6b,
  0x2a,
  0x61,
  0xde,
  0xc4,
  0x05,
  0xa9,
  0xfa,
  0xd6,
  0xa1,
  0xf5,
  0x31,
  0x15,
  0xce,
  0x0c,
  0x30,
  0xef,
  0x2f,
  0xb6,
  0xe3,
  0xcb,
  0xbf,
  0x12,
  0xd3,
  0xb4,
  0x12,
  0xa8,
  0x51,
  0xd4,
  0x5b,
  0x3d,
  0x53,
  0xa1,
  0x31,
  0x6a,
  0x20,
  0xd9,
  0x10,
  0xea,
  0xad,
  0x2e,
  0xa1,
  0xb5,
  0xc5,
  0xc0,
  0xb8,
  0xd0,
  0xeb,
  0x4e,
  0x21,
  0xe1,
  0xff,
  0x2b,
  0x19,
  0x85,
  0xa1,
  0xf2,
  0x9d,
  0x61,
  0x58,
  0xf8,
  0x65,
  0xf8,
  0x71,
  0x83,
  0xae,
  0x42,
  0xa7,
  0xbf,
  0xbb,
  0xf8,
  0x87,
  0x6b,
  0x19,
  0xb0,
  0x91,
  0x57,
  0xa4,
  0xac,
  0x1d,
  0x8d,
  0x4c,
  0x70,
  0x03,
  0x50,
  0x96,
  0x18,
  0xf8,
  0xc9,
  0xe4,
  0x67,
  0xb9,
  0x7a,
  0x75,
  0x9e,
  0xea,
  0x79,
  0x2a,
  0x12,
  0xbb,
  0x5d,
  0x0d,
  0x7b,
  0x4e,
  0xf6,
  0x91,
  0x0c,
  0xdb,
  0xbf,
  0x99,
  0x46,
  0x8f,
  0x14,
  0x39,
  0x8b,
  0x38,
  0x22,
  0x3f,
  0x75,
  0xa2,
  0xa1,
  0x6f,
  0xe3,
  0xbe,
  0x43,
  0x91,
  0xd7,
  0x87,
  0xea,
  0x2b,
  0x02,
  0xa3,
  0x9c,
  0x0d,
  0x1b,
  0xcb,
  0x36,
  0x91,
  0xf2,
  0xeb,
  0xe2,
  0x9e,
  0x47,
  0x09,
  0x49,
  0x71,
  0x5a,
  0xe6,
  0x88,
  0x1a,
  0x42,
  0x64,
  0xe3,
  0xc7,
  0xfd,
  0xad,
  0x3a,
  0xc2,
  0x4b,
  0x0f,
  0x3e,
  0x3b,
  0x3a,
  0xa8,
  0x63,
  0xc5,
  0x7f,
  0xc6,
  0x94,
  0xa2,
  0x8a,
  0x0b,
  0xa8,
  0xbe,
  0x58,
  0x52,
  0x96,
  0x7b,
  0x05,
  0x54,
  0x6a,
  0x31,
  0x28,
  0x09,
  0xf6,
  0x72,
  0xde,
  0xcf,
  0x48,
  0x11,
  0xa2,
  0x4b,
  0xde,
  0xe1,
  0xe2,
  0x12,
  0x9b,
  0x3d,
  0x51,
  0x06,
  0x77,
  0x4a,
  0xfc,
  0x81,
  0xf8,
  0xfe,
  0x1f,
  0x33,
  0x63,
  0xdf,
  0xb4,
  0xcb,
  0xb1,
  0x8b,
  0xcf,
  0x57,
  0x43,
  0xfa,
  0xac,
  0x6b,
  0x54,
  0x85,
  0x83,
  0x03,
  0x32,
  0xa5,
  0x22,
  0x28,
  0x2b,
  0x7b,
  0x38,
  0x54,
  0x47,
  0x13,
  0x71,
  0x96,
  0xba,
  0x67,
  0x45,
  0x74,
  0x17,
  0x25,
  0x8f,
  0x93,
  0x44,
  0x30,
  0xdf,
  0x17,
  0x31,
  0xe6,
  0x90,
  0xca,
  0x47,
  0x26,
  0x98,
  0xff,
  0xa0,
  0x0f,
  0x21,
  0x33,
  0xfb,
  0x89,
  0xdb,
  0x78,
  0x6d,
  0x84,
  0x0f,
  0x91,
  0xd7,
  0x02,
  0x72,
  0xdc,
  0x1a,
  0xd5,
  0xbe,
  0xf3,
  0x0c,
  0x28,
  0x00,
  0x10,
  0x28,
  0xbe,
  0xb2,
  0x34,
  0x08,
  0xfc,
  0x88,
  0x06,
  0x93,
  0xa8,
  0x09,
  0x7b,
  0xf4,
  0x6e,
  0xe4,
  0x39,
  0x50,
  0x25,
  0xff,
  0xbb,
  0x36,
  0xd6,
  0x4e,
  0x34,
  0xd5,
  0x78,
  0x69,
  0x34,
  0xf0,
  0x7b,
  0xda,
  0x0c,
  0x91,
  0x0b,
  0x3a,
  0xf0,
  0x7f,
  0x10,
  0xfa,
  0xe1,
  0x70,
  0xf6,
  0x01,
  0x47,
  0xfd,
  0x32,
  0xf9,
  0x60,
  0x59,
  0x7f,
  0x68,
  0x5c,
  0xc0,
  0xeb,
  0x81,
  0x44,
  0xb0,
  0x94,
  0xb7,
  0x9e,
  0xd9,
  0x32,
  0x15,
  0xd1,
  0xd4,
  0x53,
  0x50,
  0x48,
  0x95,
  0x68,
  0x97,
  0x57,
  0xa1,
  0x83,
  0x30,
  0xe1,
  0xff,
  0xdd,
  0xc4,
  0xb5,
  0xef,
  0x19,
  0x74,
  0xbc,
  0x5c,
  0x49,
  0xb3,
  0xd3,
  0x12,
  0xb3,
  0xd2,
  0x78,
  0xae,
  0x54,
  0x59,
  0x27,
  0x58,
  0x20,
  0x1b,
  0x81,
  0x32,
  0x0e,
  0x08,
  0x32,
  0x8e,
  0xd6,
  0xc0,
  0x8e,
  0xe2,
  0x77,
  0xeb,
  0x00,
  0x7b,
  0x7a,
  0x4a,
  0x22,
  0xf3,
  0xf8,
  0x8c,
  0xab,
  0x63,
  0x5d,
  0xe0,
  0x0b,
  0x57,
  0xe8,
  0x4e,
  0xd7,
  0x85,
  0xf9,
  0xc5,
  0xe6,
  0x3d,
  0x09,
  0xf3,
  0x37,
  0x9e,
  0x77,
  0xd7,
  0x99,
  0x8c,
  0x09,
  0x17,
  0x08,
  0x64,
  0x2c,
  0x12,
  0xd7,
  0x6c,
  0x01,
  0xb3,
  0x91,
  0x0b,
  0x18,
  0x0b,
  0x9f,
  0xbd,
  0xf9,
  0x9c,
  0xa9,
  0xc4,
  0x66,
  0x75,
  0xbd,
  0x9e,
  0x61,
  0x01,
  0x31,
  0x39,
  0xef,
  0x9f,
  0x48,
  0xe7,
  0x99,
  0xf1,
  0x96,
  0x12,
  0xb7,
  0xf3,
  0x22,
  0xaf,
  0x6b,
  0xd2,
  0x50,
  0x73,
  0x6d,
  0x79,
  0x7c,
  0xc8,
  0x8c,
  0xeb,
  0x65,
  0x7c,
  0xef,
  0x52,
  0x4f,
  0x3d,
  0x1f,
  0xdb,
  0xe6,
  0xc8,
  0xc4,
  0x3e,
  0xe4,
  0xdb,
  0x31,
  0x1f,
  0x71,
  0xee,
  0xa1,
  0x17,
  0x4d,
  0xa5,
  0x3e,
  0x90,
  0xae,
  0x03,
  0xe5,
  0x53,
  0xe9,
  0x5e,
  0xaa,
  0xe2,
  0xd2,
  0x16,
  0x1d,
  0x86,
  0xe4,
  0x04,
  0x49,
  0x27,
  0x20,
  0xb2,
  0x80,
  0xde,
  0xb4,
  0x4f,
  0xd8,
  0x4a,
  0x62,
  0x60,
  0x74,
  0xa5,
  0x9e,
  0x36,
  0x82,
  0x94,
  0x74,
  0x22,
  0x07,
  0xc2,
  0x2f,
  0x69,
  0x5c,
  0x2b,
  0xba,
  0xf9,
  0x76,
  0x38,
  0xc3,
  0xd8,
  0xe9,
  0x8e,
  0xa4,
  0x60,
  0xaa,
  0xa5,
  0x02,
  0x2b,
  0x97,
  0x1a,
  0x31,
  0xce,
  0xb6,
  0xc4,
  0x5d,
  0x48,
  0x3f,
  0x88,
  0x69,
  0x38,
  0x5b,
  0xec,
  0x96,
  0xd1,
  0xa9,
  0x6c,
  0xe2,
  0x8d,
  0x84,
  0x8f,
  0x35,
  0xa3,
  0x06,
  0xb8,
  0x3d,
  0x39,
  0xca,
  0xbc,
  0x14,
  0x58,
  0x74,
  0x37,
  0xa6,
  0xa3,
  0xf1,
  0x9d,
  0xd4,
  0xc6,
  0x7e,
  0x12,
  0x57,
  0xae,
  0x69,
  0xfa,
  0x65,
  0x7d,
  0x99,
  0x4f,
  0x15,
  0x3b,
  0xce,
  0xb4,
  0x82,
  0x4d,
  0xa8,
  0x4d,
  0xb1,
  0xa5,
  0x69,
  0x4b,
  0x32,
  0xbd,
  0x79,
  0x49,
  0x88,
  0x44,
  0xac,
  0x59,
  0x49,
  0x95,
  0x46,
  0xdc,
  0x04,
  0xeb,
  0xba,
  0x14,
  0xe5,
  0x56,
  0x34,
  0x7a,
  0x19,
  0x6b,
  0xdd,
  0xd0,
  0xf1,
  0xbc,
  0xd7,
  0xf4,
  0xc9,
  0x0d,
  0x0d,
  0x7a,
  0xa6,
  0x43,
  0xad,
  0xf8,
  0xa0,
  0x1b,
  0x70,
  0x1e,
  0x05,
  0x9f,
  0x9f,
  0x8c,
  0x38,
  0x58,
  0xd4,
  0x62,
  0x5d,
  0x43,
  0x83,
  0x96,
  0xb7,
  0x83,
  0x37,
  0x09,
  0xcb,
  0xdb,
  0x9c,
  0x57,
  0x4c,
  0xd9,
  0x40,
  0x71,
  0xb5,
  0xd1,
  0x18,
  0xeb,
  0xb6,
  0x90,
  0xc3,
  0x15,
  0x4f,
  0xcc,
  0x91,
  0xcb,
  0xbd,
  0x5c,
  0x41,
  0x0c,
  0x17,
  0x2c,
  0x8d,
  0x4c,
  0xb6,
  0xee,
  0x66,
  0x88,
  0x58,
  0x90,
  0xfe,
  0x1d,
  0x03,
  0x70,
  0x89,
  0x58,
  0xaa,
  0x50,
  0xc2,
  0xcc,
  0x91,
  0x0a,
  0x2f,
  0x66,
  0x70,
  0x03,
  0x24,
  0x41,
  0x59,
  0x60,
  0x88,
  0x3a,
  0x59,
  0xfa,
  0x59,
  0x42,
  0xdf,
  0x11,
  0xf0,
  0x75,
  0xe0,
  0xc3,
  0x04,
  0xee,
  0xb6,
  0x3a,
  0x70,
  0x57,
  0xcc,
  0xa7,
  0xb3,
  0x42,
  0xfa,
  0xf1,
  0x3b,
  0x39,
  0xb0,
  0x2c,
  0x60,
  0x97,
  0xd4,
  0xcb,
  0x31,
  0x14,
  0x6b,
  0x94,
  0xf1,
  0x21,
  0xfa,
  0x57,
  0x5f,
  0xf8,
  0xaa,
  0x5c,
  0xb9,
  0x71,
  0x2d,
  0xa0,
  0x7d,
  0x96,
  0x62,
  0xbe,
  0xf4,
  0xf4,
  0xb9,
  0xae,
  0x6f,
  0xb6,
  0x56,
  0x30,
  0x4e,
  0x73,
  0xf8,
  0x05,
  0xc5,
  0xc1,
  0x97,
  0xe3,
  0x5d,
  0x91,
  0xcf,
  0x25,
  0x3b,
  0x39,
  0xff,
  0x44,
  0x22,
  0x50,
  0x2f,
  0x09,
  0x39,
  0x3c,
  0xb4,
  0x7e,
  0x8c,
  0x8c,
  0x95,
  0xa8,
  0x53,
  0x05,
  0xab,
  0xf6,
  0xf5,
  0x7e,
  0x8b,
  0x77,
  0xca,
  0x6b,
  0x23,
  0xce,
  0xa3,
  0x3a,
  0x25,
  0xe5,
  0x0a,
  0x60,
  0x26,
  0x63,
  0x48,
  0x31,
  0x85,
  0xde,
  0x2a,
  0x73,
  0x0c,
  0xcf,
  0x83,
  0xb0,
  0x57,
  0x48,
  0x70,
  0x4e,
  0xf7,
  0x67,
  0x5d,
  0x60,
  0x55,
  0x89,
  0xca,
  0x39,
  0x58,
  0x3e,
  0xcd,
  0xc4,
  0xc5,
  0xff,
  0x55,
  0x95,
  0x68,
  0xa0,
  0x34,
  0xbe,
  0xf6,
  0x86,
  0xda,
  0x62,
  0xb0,
  0x98,
  0xe1,
  0x0a,
  0xc7,
  0xf5,
  0x4c,
  0xb9,
  0x82,
  0x6a,
  0x8e,
  0xc1,
  0x20,
  0xa1,
  0x4c,
  0x52,
  0x7d,
  0x1a,
  0xe1,
  0xd7,
  0x76,
  0xd9,
  0xa5,
  0x00,
  0x0d,
  0xe3,
  0xed,
  0x9d,
  0x4c,
  0x69,
  0xd0,
  0x30,
  0xe9,
  0xc1,
  0xae,
  0x40,
  0xac,
  0x18,
  0x71,
  0x6e,
  0x93,
  0xe8,
  0x91,
  0x48,
  0xb2,
  0x2a,
  0xd8,
  0xe0,
  0xdb,
  0x4a,
  0xe9,
  0x1b,
  0x02,
  0xde,
  0x81,
  0xc9,
  0x5d,
  0x15,
  0x7b,
  0x77,
  0x4d,
  0xf0,
  0x94,
  0x07,
  0xfe,
  0x32,
  0xf3,
  0xfb,
  0xd0,
  0x18,
  0x66,
  0x95,
  0x73,
  0xc8,
  0x6c,
  0x9f,
  0xd4,
  0x89,
  0xf6,
  0x09,
  0xba,
  0xb7,
  0xec,
  0x37,
  0x2f,
  0x74,
  0x71,
  0x17,
  0x9f,
  0x1d,
  0xe6,
  0xf5,
  0xc1,
  0x82,
  0xaf,
  0x0d,
  0x38,
  0xd5,
  0xb7,
  0xe4,
  0xf8,
  0x5d,
  0xb3,
  0x55,
  0x6a,
  0xf2,
  0x29,
  0x6d,
  0x4d,
  0x28,
  0x2f,
  0xf7,
  0x62,
  0x48,
  0xf3,
  0xd5,
  0xc5,
  0x03,
  0xfd,
  0x14,
  0x1c,
  0xe4,
  0x36,
  0xbd,
  0x72,
  0x88,
  0xa7,
  0x6b,
  0xdf,
  0x8f,
  0x02,
  0xa1,
  0xef,
  0x50,
  0xe1,
  0xd8,
  0xbf,
  0x4f,
  0xcf,
  0x59,
  0xe7,
  0x6f,
  0x09,
  0xd0,
  0x1a,
  0xe6,
  0x04,
  0x9c,
  0x8e,
  0xf3,
  0xae,
  0xe6,
  0x1c,
  0x51,
  0x74,
  0x78,
  0x26,
  0x69,
  0x06,
  0x4a,
  0x3b,
  0x4a,
  0xdc,
  0xdb,
  0x7b,
  0x59,
  0x76,
  0x44,
  0xbb,
  0xc7,
  0x66,
  0x0d,
  0x67,
  0xc5,
  0x0e,
  0xbd,
  0x2b,
  0x78,
  0x29,
  0x33,
  0x50,
  0xad,
  0x0b,
  0xb7,
  0xe6,
  0x4d,
  0xa7,
  0xce,
  0xa5,
  0x8e,
  0x53,
  0xd0,
  0x93,
  0xee,
  0x4d,
  0x3a,
  0x65,
  0xdf,
  0xfc,
  0xc3,
  0xa6,
  0x40,
  0xf6,
  0x30,
  0x98,
  0x92,
  0xc5,
  0xe6,
  0xdc,
  0xe7,
  0x69,
  0x44,
  0xd4,
  0x99,
  0x9b,
  0xad,
  0xc3,
  0xbf,
  0xd7,
  0x67,
  0xb9,
  0x5e,
  0x16,
  0x26,
  0x30,
  0x61,
  0x5e,
  0x66,
  0x75,
  0x4a,
  0xfa,
  0x7b,
  0xc7,
  0xa5,
  0x88,
  0x69,
  0x40,
  0x3f,
  0xb7,
  0x74,
  0x77,
  0x1a,
  0xcc,
  0x75,
  0xe1,
  0x1e,
  0xe9,
  0xf2,
  0xfb,
  0x8f,
  0x0c,
  0xeb,
  0x28,
  0x42,
  0xd8,
  0x74,
  0x5a,
  0x8e,
  0x15,
  0x07,
  0x72,
  0x02,
  0xf8,
  0x96,
  0x67,
  0xdb,
  0x23,
  0x61,
  0x28,
  0x33,
  0x6a,
  0x8d,
  0x42,
  0xfa,
  0x5a,
  0x70,
  0x40,
  0xa4,
  0x7a,
  0xac,
  0xd5,
  0xa6,
  0x4e,
  0x02,
  0xbb,
  0xa1,
  0x1f,
  0xe2,
  0x58,
  0x5a,
  0x7c,
  0xc5,
  0x25,
  0x71,
  0x7e,
  0x3a,
  0xce,
  0xcc,
  0xcf,
  0xc1,
  0x18,
  0xd7,
  0x68,
  0x5a,
  0x85,
  0x6d,
  0x1c,
  0xdb,
  0xb9,
  0x94,
  0xd7,
  0x04,
  0x9a,
  0xeb,
  0xa5,
  0x53,
  0x39,
  0xe3,
  0x75,
  0x98,
  0x73,
  0xb0,
  0x9a,
  0x47,
  0x55,
  0xfc,
  0x15,
  0x90,
  0x43,
  0x60,
  0x94,
  0x2f,
  0xd7,
  0x92,
  0x38,
  0x03,
  0x8a,
  0x5e,
  0x18,
  0x5f,
  0x13,
  0x55,
  0x89,
  0x22,
  0x92,
  0x47,
  0x1a,
  0x88,
  0x6b,
  0x71,
  0x61,
  0xbe,
  0xf3,
  0x75,
  0x77,
  0x37,
  0xcc,
  0x0d,
  0x44,
  0xc0,
  0x0f,
  0x7e,
  0x7a,
  0x54,
  0x2e,
  0xcd,
  0x62,
  0xaf,
  0x97,
  0xb3,
  0x58,
  0xa4,
  0x18,
  0x50,
  0x17,
  0x2e,
  0x04,
  0xa1,
  0xb4,
  0x48,
  0x19,
  0xb2,
  0x6b,
  0x7c,
  0x1f,
  0x93,
  0x1c,
  0x3c,
  0x50,
  0x0b,
  0x93,
  0xf2,
  0x7a,
  0x0e,
  0x89,
  0xd8,
  0xe5,
  0xef,
  0x6e,
  0x88,
  0xf4,
  0x54,
  0xe3,
  0x52,
  0x8d,
  0xec,
  0x09,
  0x51,
  0x39,
  0xe2,
  0x7b,
  0x3a,
  0x0b,
  0x0f,
  0x1b,
  0xfa,
  0x40,
  0xf2,
  0x8f,
  0xfd,
  0xa9,
  0x5f,
  0x8a,
  0x4e,
  0xcb,
  0xf9,
  0xca,
  0x63,
  0xc3,
  0x60,
  0xe4,
  0xb5,
  0xeb,
  0x2a,
  0xc1,
  0x11,
  0x3d,
  0x92,
  0xe7,
  0xb1,
  0x79,
  0xf1,
  0x77,
  0x08,
  0x08,
  0xef,
  0xfa,
  0x5f,
  0x9e,
  0x79,
  0xda,
  0x24,
  0xa1,
  0x71,
  0xb1,
  0xfc,
  0x4c,
  0x26,
  0x44,
  0x9d,
  0x91,
  0x89,
  0x4d,
  0x5e,
  0xc2,
  0x1c,
  0xfb,
  0x89,
  0xee,
  0xa9,
  0x39,
];

List<int> _decode(int cursor, List<int> data) {
  return data.map((e) {
    final value = e ^ _bnutKey[cursor];
    cursor = (cursor + 1) % _bnutKey.length;
    return value;
  }).toList();
}

/// A [BnutDecoder] converts bnut bytes data to utf8 bytes representing Squirrel code (.nut extension).
class BnutDecoder extends Converter<List<int>, String> {
  @override
  String convert(List<int> data) {
    var cursor = data.length & 255;
    return utf8.decode(_decode(cursor, data));
  }
}

/// A [BnutEncoder] converts Squirrel code (.nut extension) to bnut bytes data.
class BnutEncoder extends Converter<String, List<int>> {
  @override
  List<int> convert(String data) {
    final bytes = utf8.encode(data);
    var cursor = bytes.length & 255;
    return _decode(cursor, bytes);
  }
}

/// An instance of the default implementation of the [BnutCodec].
///
/// This instance provides a convenient access to the most common bnut
/// use cases.
///
/// Examples:
/// ```dart
/// var encoded = bnut.encode('print("hello")');
/// var decoded = bnut.decode(encoded);
/// ```
/// The top-level [bnutEncode] and [bnutDecode] functions may be used instead if
/// a local variable shadows the [bnut] constant.
const BnutCodec bnut = BnutCodec();

/// Converts Squirrel code to bytes.
List<int> bnutEncode(String code) => bnut.encode(code);

/// Converts bytes to Squirrel code.
String bnutDecode(List<int> data) => bnut.decode(data);

/// A [BnutCodec] encodes String to bnut bytes data and decodes bytes to
/// Squirrel code (.nut extension).
///
/// Examples:
/// ```dart
/// var encoded = bnut.encode('print("hello")');
/// var decoded = bnut.decode(encoded);
/// ```
class BnutCodec extends Codec<String, List<int>> {
  const BnutCodec();

  @override
  Converter<List<int>, String> get decoder => BnutDecoder();

  @override
  Converter<String, List<int>> get encoder => BnutEncoder();
}
