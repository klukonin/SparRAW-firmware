/* hwd_pcie__set_mode_map @ 0x8d18e8, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__set_mode_map
hwd_pcie__set_mode_map:
	.global L_8d18e8
L_8d18e8:
	push_s blink
L_8d18ea:
	push_s r13
L_8d18ec:
	brhs.d r0,0x5,L_8d1904
L_8d18f0:
	mov_s r13,r0
L_8d18f2:
	ldb.x r10,[0x8038f4,r13]
L_8d18fa:
	add r0,pcl,0xc
L_8d18fe:
	add1 r0,r0,r10
L_8d1902:
	j_s [r0]
	.global L_8d1904
L_8d1904:
	mov_s r0,blink
L_8d1906:
	mov_s r1,0x12d8
L_8d190c:
	bl L_8c9b28
L_8d1910:
	asl_s r1,r13,0x4
L_8d1912:
	or_s r1,r1,r13
L_8d1914:
	asl r0,r13,0x8
L_8d1918:
	or_s r0,r0,r1
L_8d191a:
	asl r1,r13,0xc
L_8d191e:
	or_s r1,r1,r0
L_8d1920:
	asl r0,r13,0x10
L_8d1924:
	or_s r0,r0,r1
L_8d1926:
	asl r1,r13,0x14
L_8d192a:
	or_s r1,r1,r0
L_8d192c:
	asl r0,r13,0x18
L_8d1930:
	or_s r0,r0,r1
L_8d1932:
	asl_s r13,r13,0x1c
L_8d1934:
	or_s r0,r0,r13
L_8d1936:
	and r1,r0,0xffff0000
L_8d193e:
	mov_s r3,0x883000
L_8d1944:
	mov_s r2,0x882f00
L_8d194a:
	st_s r1,[r2,0x64]
L_8d194c:
	st_s r0,[r2,0x68]
L_8d194e:
	extw_s r1,r0
L_8d1950:
	st_s r1,[r2,0x6c]
L_8d1952:
	bmsk r1,r0,0x17
L_8d1956:
	st_s r1,[r2,0x70]
L_8d1958:
	st_s r1,[r2,0x74]
L_8d195a:
	st_s r1,[r2,0x78]
L_8d195c:
	st_s r1,[r2,0x7c]
L_8d195e:
	st r0,[r3, -0x80]
L_8d1962:
	extb_s r0,r0
L_8d1964:
	st r0,[r3, -0x7c]
L_8d1968:
	b L_8c025c
