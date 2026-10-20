/* boot__install_handler_ptrs @ 0x8c18d4, 972 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, boot__fill_sysapi_3c_thunk, calib_silent_rssi__ctor, cxx__vec_new, field_set_0x04__8c1864, field_set_0x04__8c1870, memset0_words, obj__store3_thunk, obj_vt8005c4__ctor, obj_vt8030e0__ctor
 * Глобалы (через gp): 0x8001a0, 0x8001a4, 0x8001a8, 0x8001ac, 0x8001b0, 0x8001b4, 0x8001b8, 0x8001bc, 0x8001c0, 0x8001c4, 0x8001c8, 0x8001cc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__install_handler_ptrs
boot__install_handler_ptrs:
	.global L_8c18d4
L_8c18d4:
	push_s blink
L_8c18d6:
	mov_s r1,0x8430b8
L_8c18dc:
	mov_s r0,0x8006c4
L_8c18e2:
	st_s r0,[r1,0x24]
L_8c18e4:
	mov_s r0,0x800664
L_8c18ea:
	st_s r0,[r1,0x4c]
L_8c18ec:
	mov_s r0,0x800604
L_8c18f2:
	st_s r0,[r1,0x74]
L_8c18f4:
	mov_s r0,0x80072c
L_8c18fa:
	st r0,[r1, 0x9c]
L_8c18fe:
	mov_s r0,0x804b5c
L_8c1904:
	bl.d L_8f0004
L_8c1908:
	mov_s r1,0x0
L_8c190a:
	mov_s r1,0x847ae4
L_8c1910:
	mov_s r0,0x800694
L_8c1916:
	st_s r0,[r1,0x24]
L_8c1918:
	pop_s blink
L_8c191a:
	j_s [blink]
L_8c191c:
	mov_s r0,0x8005b8
L_8c1922:
	b L_8c1d68
L_8c1926:
	nop_s
L_8c1928:
	mov_s r0,0x8006f4
L_8c192e:
	j_s.d [blink]
L_8c1930:
	st.as r0,[gp,0x5b]
L_8c1934:
	mov_s r1,0x803c94
L_8c193a:
	mov_s r0,0x8008d8
L_8c1940:
	st_s r0,[r1,0x10]
L_8c1942:
	mov_s r0,0x8008e0
L_8c1948:
	j_s.d [blink]
L_8c194a:
	st_s r0,[r1,0x24]
L_8c194c:
	ld_s r0,[gp,0x1dc]
L_8c194e:
	add1 r1,r0,r0
L_8c1952:
	add_s r1,r1,r0
L_8c1954:
	asl_s r0,r0
L_8c1956:
	st.as r1,[gp,0x78]
L_8c195a:
	st.as r0,[gp,0x76]
L_8c195e:
	ld.as r1,[gp,0x1a]
L_8c1962:
	mov_s r0,0x8034c0
L_8c1968:
	j_s.d [blink]
L_8c196a:
	st_s r1,[r0,0x10]
L_8c196c:
	push_s blink
L_8c196e:
	mov_s r0,0x805170
L_8c1974:
	bl.d L_8f0000
L_8c1978:
	mov_s r1,0x0
L_8c197a:
	mov_s r2,0x801170
L_8c1980:
	mov_s r3,0x801230
L_8c1986:
	mov_s r0,0x8051f8
L_8c198c:
	mov_s r1,0x0
L_8c198e:
	bl.d L_8c17b4
L_8c1992:
	mov r4,0x30
L_8c1996:
	pop_s blink
L_8c1998:
	j_s [blink]
L_8c199a:
	nop_s
L_8c199c:
	mov_s r0,0x8042c8
L_8c19a2:
	b.d L_8c17c0
L_8c19a6:
	mov_s r1,0x0
L_8c19a8:
	mov_s r1,0x84e7e0
L_8c19ae:
	mov_s r0,0x8007a0
L_8c19b4:
	j_s.d [blink]
L_8c19b6:
	st_s r0,[r1,0x2c]
L_8c19b8:
	mov_s r1,0x842840
L_8c19be:
	mov_s r0,0x800874
L_8c19c4:
	st_s r0,[r1]
L_8c19c6:
	mov_s r0,0x800880
L_8c19cc:
	j_s.d [blink]
L_8c19ce:
	st_s r0,[r1,0x4]
L_8c19d0:
	ld_s r0,[gp,0x300]
L_8c19d2:
	add1 r1,r0,r0
L_8c19d6:
	add_s r0,r0,r1
L_8c19d8:
	st.as r0,[gp,0xc1]
L_8c19dc:
	ld.as r1,[gp,0x14]
L_8c19e0:
	mov_s r0,0x802fb4
L_8c19e6:
	j_s.d [blink]
L_8c19e8:
	st_s r1,[r0,0x10]
L_8c19ea:
	nop_s
L_8c19ec:
	mov_s r1,0x804dbc
L_8c19f2:
	mov_s r0,0x8008e8
L_8c19f8:
	st_s r0,[r1]
L_8c19fa:
	mov_s r1,0x804e64
L_8c1a00:
	mov_s r0,0x800918
L_8c1a06:
	j_s.d [blink]
L_8c1a08:
	st_s r0,[r1]
L_8c1a0a:
	nop_s
L_8c1a0c:
	push_s blink
L_8c1a0e:
	push_s r13
L_8c1a10:
	mov_s r13,0x804914
L_8c1a16:
	mov_s r0,r13
L_8c1a18:
	bl.d L_8c1864
L_8c1a1c:
	mov_s r1,0x0
L_8c1a1e:
	add r0,r13,0x8
L_8c1a22:
	bl.d L_8c1870
L_8c1a26:
	mov_s r1,0x0
L_8c1a28:
	b L_8c025c
L_8c1a2c:
	mov_s r1,0x80426c
L_8c1a32:
	mov_s r0,0x800770
L_8c1a38:
	j_s.d [blink]
L_8c1a3a:
	st_s r0,[r1,0x58]
L_8c1a3c:
	mov_s r1,0x806214
L_8c1a42:
	mov_s r0,0x800848
L_8c1a48:
	j_s.d [blink]
L_8c1a4a:
	st_s r0,[r1]
L_8c1a4c:
	mov_s r1,0x805fe4
L_8c1a52:
	mov_s r0,0x800714
L_8c1a58:
	j_s.d [blink]
L_8c1a5a:
	st_s r0,[r1]
L_8c1a5c:
	mov_s r0,0x804944
L_8c1a62:
	mov_s r3,0x2d154
L_8c1a68:
	mov_s r1,0x6
L_8c1a6a:
	mov_s r2,0x44
L_8c1a6c:
	b.d L_8c1700
L_8c1a70:
	mov r4,0x402
L_8c1a74:
	mov_s r1,0x842274
L_8c1a7a:
	mov_s r3,0x8008ac
L_8c1a80:
	st_s r3,[r1,0x50]
L_8c1a82:
	mov_s r2,0x800778
L_8c1a88:
	st_s r2,[r1,0x6c]
L_8c1a8a:
	mov_s r0,0x80071c
L_8c1a90:
	st_s r0,[r1,0x4c]
L_8c1a92:
	mov_s r1,0x842148
L_8c1a98:
	st r3,[r1, 0xec]
L_8c1a9c:
	st.as r2,[r1,0x42]
L_8c1aa0:
	st r0,[r1, 0xe8]
L_8c1aa4:
	st_s r3,[r1,0x5c]
L_8c1aa6:
	st_s r2,[r1,0x78]
L_8c1aa8:
	j_s.d [blink]
L_8c1aaa:
	st_s r0,[r1,0x58]
L_8c1aac:
	mov_s r1,0x843040
L_8c1ab2:
	mov_s r0,0x8006fc
L_8c1ab8:
	j_s.d [blink]
L_8c1aba:
	st_s r0,[r1,0x44]
L_8c1abc:
	mov_s r3,0x2d15c
L_8c1ac2:
	mov_s r0,0x854dd4
L_8c1ac8:
	mov_s r1,0x8
L_8c1aca:
	mov_s r2,0xa4
L_8c1acc:
	b.d L_8c1700
L_8c1ad0:
	mov r4,0x402
L_8c1ad4:
	mov_s r1,0x804e90
L_8c1ada:
	mov_s r0,0x80070c
L_8c1ae0:
	j_s.d [blink]
L_8c1ae2:
	st.as r0,[r1,0x8d]
L_8c1ae6:
	nop_s
L_8c1ae8:
	mov_s r1,0x8041f0
L_8c1aee:
	mov_s r0,0x800790
L_8c1af4:
	j_s.d [blink]
L_8c1af6:
	st_s r0,[r1,0x44]
L_8c1af8:
	mov_s r1,0x803d10
L_8c1afe:
	mov_s r0,0x80082c
L_8c1b04:
	st_s r0,[r1,0x34]
L_8c1b06:
	mov_s r0,0x800800
L_8c1b0c:
	st_s r0,[r1,0x28]
L_8c1b0e:
	mov_s r0,0x8007e4
L_8c1b14:
	st_s r0,[r1,0x1c]
L_8c1b16:
	mov_s r0,0x8007b8
L_8c1b1c:
	j_s.d [blink]
L_8c1b1e:
	st_s r0,[r1,0x10]
L_8c1b20:
	ld_s r0,[gp,0x48]
L_8c1b22:
	mov_s r1,0x802b08
L_8c1b28:
	j_s.d [blink]
L_8c1b2a:
	st_s r0,[r1,0x58]
L_8c1b2c:
	ld_s r0,[gp,0x44]
L_8c1b2e:
	mov_s r1,0x802940
L_8c1b34:
	j_s.d [blink]
L_8c1b36:
	st_s r0,[r1,0x3c]
L_8c1b38:
	ld_s r0,[gp,0x4c]
L_8c1b3a:
	mov_s r1,0x802b64
L_8c1b40:
	j_s.d [blink]
L_8c1b42:
	st_s r0,[r1,0x4c]
L_8c1b44:
	ld_s r0,[gp,-0x2c]
L_8c1b46:
	mov_s r1,0x802234
L_8c1b4c:
	j_s.d [blink]
L_8c1b4e:
	st_s r0,[r1,0x10]
L_8c1b50:
	ld_s r0,[gp,0x40]
L_8c1b52:
	mov_s r1,0x802758
L_8c1b58:
	j_s.d [blink]
L_8c1b5a:
	st_s r0,[r1,0x58]
L_8c1b5c:
	ld_s r0,[gp,0x3c]
L_8c1b5e:
	mov_s r1,0x802754
L_8c1b64:
	j_s.d [blink]
L_8c1b66:
	st_s r0,[r1]
L_8c1b68:
	ld_s r0,[gp,0x58]
L_8c1b6a:
	mov_s r1,0x8030f4
L_8c1b70:
	j_s.d [blink]
L_8c1b72:
	st_s r0,[r1,0x10]
L_8c1b74:
	ld_s r0,[gp,0x64]
L_8c1b76:
	mov_s r1,0x803424
L_8c1b7c:
	j_s.d [blink]
L_8c1b7e:
	st_s r0,[r1,0x10]
L_8c1b80:
	ld_s r0,[gp,-0x20]
L_8c1b82:
	mov_s r1,0x802f58
L_8c1b88:
	j_s.d [blink]
L_8c1b8a:
	st_s r0,[r1,0x10]
L_8c1b8c:
	ld_s r0,[gp,-0x24]
L_8c1b8e:
	mov_s r1,0x802da0
L_8c1b94:
	j_s.d [blink]
L_8c1b96:
	st_s r0,[r1,0x10]
L_8c1b98:
	ld_s r0,[gp,-0x28]
L_8c1b9a:
	mov_s r1,0x802cc4
L_8c1ba0:
	j_s.d [blink]
L_8c1ba2:
	st_s r0,[r1,0x10]
L_8c1ba4:
	ld_s r0,[gp,0x38]
L_8c1ba6:
	mov_s r1,0x802458
L_8c1bac:
	j_s.d [blink]
L_8c1bae:
	st_s r0,[r1,0x10]
L_8c1bb0:
	ld_s r0,[gp,0x24]
L_8c1bb2:
	mov_s r1,0x801ca8
L_8c1bb8:
	j_s.d [blink]
L_8c1bba:
	st_s r0,[r1,0x10]
L_8c1bbc:
	ld_s r0,[gp,0x2c]
L_8c1bbe:
	mov_s r1,0x801e70
L_8c1bc4:
	j_s.d [blink]
L_8c1bc6:
	st_s r0,[r1,0x4c]
L_8c1bc8:
	ld_s r0,[gp,0x20]
L_8c1bca:
	mov_s r1,0x801c30
L_8c1bd0:
	j_s.d [blink]
L_8c1bd2:
	st_s r0,[r1,0x10]
L_8c1bd4:
	ld_s r0,[gp,0x28]
L_8c1bd6:
	mov_s r1,0x801d64
L_8c1bdc:
	j_s.d [blink]
L_8c1bde:
	st_s r0,[r1,0x10]
L_8c1be0:
	ld_s r0,[gp,0x1c]
L_8c1be2:
	mov_s r1,0x801bec
L_8c1be8:
	j_s.d [blink]
L_8c1bea:
	st_s r0,[r1,0x10]
L_8c1bec:
	ld_s r0,[gp,0x34]
L_8c1bee:
	mov_s r1,0x802338
L_8c1bf4:
	j_s.d [blink]
L_8c1bf6:
	st_s r0,[r1,0x10]
L_8c1bf8:
	ld_s r0,[gp,0x60]
L_8c1bfa:
	mov_s r1,0x80338c
L_8c1c00:
	j_s.d [blink]
L_8c1c02:
	st_s r0,[r1,0x10]
L_8c1c04:
	ld_s r0,[gp,0x5c]
L_8c1c06:
	mov_s r1,0x803210
L_8c1c0c:
	j_s.d [blink]
L_8c1c0e:
	st_s r0,[r1,0x10]
L_8c1c10:
	ld_s r0,[gp,0x30]
L_8c1c12:
	mov_s r1,0x801ec0
L_8c1c18:
	j_s.d [blink]
L_8c1c1a:
	st_s r0,[r1,0x58]
L_8c1c1c:
	ld_s r0,[gp,0x54]
L_8c1c1e:
	mov_s r1,0x8030e0
L_8c1c24:
	j_s.d [blink]
L_8c1c26:
	st_s r0,[r1,0x10]
L_8c1c28:
	mov_s r3,0x2d190
L_8c1c2e:
	mov_s r0,0x847b48
L_8c1c34:
	mov_s r1,0x9
L_8c1c36:
	mov_s r2,0x78
L_8c1c38:
	b.d L_8c1700
L_8c1c3c:
	mov r4,0x402
L_8c1c40:
	mov_s r0,0x8052e4
L_8c1c46:
	b.d L_8c18a0
L_8c1c4a:
	mov_s r1,0x0
L_8c1c4c:
	mov_s r1,0x80676c
L_8c1c52:
	mov_s r0,0x800694
L_8c1c58:
	j_s.d [blink]
L_8c1c5a:
	st_s r0,[r1,0x24]
L_8c1c5c:
	mov_s r0,0x805234
L_8c1c62:
	b.d L_8c18bc
L_8c1c66:
	mov_s r1,0x0
L_8c1c68:
	mov_s r0,0x8054bc
L_8c1c6e:
	b.d L_8c179c
L_8c1c72:
	mov_s r1,0x0
L_8c1c74:
	push_s blink
L_8c1c76:
	push_s r13
L_8c1c78:
	mov_s r1,0x800594
L_8c1c7e:
	ld_s r0,[r1]
L_8c1c80:
	brne_s r0,0,L_8c1c9c
L_8c1c82:
	mov_s r0,0x1
L_8c1c84:
	st_s r0,[r1]
L_8c1c86:
	mov_s r1,0x801b1c
L_8c1c8c:
	ld_s r13,[r1,0x8]
L_8c1c8e:
	mov_s r0,0x0
L_8c1c90:
	st_s r0,[r1,0x8]
L_8c1c92:
	breq_s r13,0,L_8c1c9c
	.global L_8c1c94
L_8c1c94:
	ld_s r0,[r13,0x4]
L_8c1c96:
	jl_s [r0]
L_8c1c98:
	ld_s r13,[r13,0x8]
L_8c1c9a:
	brne_s r13,0,L_8c1c94
	.global L_8c1c9c
L_8c1c9c:
	b L_8c025c
