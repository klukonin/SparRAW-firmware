/* hwd_pcie__set_mode_map @ 0x8cec0c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_pcie.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_pcie__set_mode_map,"ax",@progbits
	.global hwd_pcie__set_mode_map
hwd_pcie__set_mode_map:
	.global L_8cec0c
L_8cec0c:
	push_s blink
L_8cec0e:
	push_s r13
L_8cec10:
	brhs.d r0,0x5,L_8cec28
L_8cec14:
	mov_s r13,r0
L_8cec16:
	ldb.x r10,[0x80309c,r13]
L_8cec1e:
	add r0,pcl,0xc
L_8cec22:
	add1 r0,r0,r10
L_8cec26:
	j_s [r0]
	.global L_8cec28
L_8cec28:
	mov_s r0,blink
L_8cec2a:
	mov_s r2,0x1018a0c
L_8cec30:
	mov_s r1,0x12d8
L_8cec36:
	bl.d L_8c82c0
L_8cec3a:
	mov_s r3,0x2d
L_8cec3c:
	asl_s r1,r13,0x4
L_8cec3e:
	or_s r1,r1,r13
L_8cec40:
	asl r0,r13,0x8
L_8cec44:
	or_s r0,r0,r1
L_8cec46:
	asl r1,r13,0xc
L_8cec4a:
	or_s r1,r1,r0
L_8cec4c:
	asl r0,r13,0x10
L_8cec50:
	or_s r0,r0,r1
L_8cec52:
	asl r1,r13,0x14
L_8cec56:
	or_s r1,r1,r0
L_8cec58:
	asl r0,r13,0x18
L_8cec5c:
	or_s r0,r0,r1
L_8cec5e:
	asl_s r13,r13,0x1c
L_8cec60:
	or_s r0,r0,r13
L_8cec62:
	and r1,r0,0xffff0000
L_8cec6a:
	mov_s r3,0x883000
L_8cec70:
	mov_s r2,0x882f00
L_8cec76:
	st_s r1,[r2,0x64]
L_8cec78:
	st_s r0,[r2,0x68]
L_8cec7a:
	extw_s r1,r0
L_8cec7c:
	st_s r1,[r2,0x6c]
L_8cec7e:
	bmsk r1,r0,0x17
L_8cec82:
	st_s r1,[r2,0x70]
L_8cec84:
	st_s r1,[r2,0x74]
L_8cec86:
	st_s r1,[r2,0x78]
L_8cec88:
	st_s r1,[r2,0x7c]
L_8cec8a:
	st r0,[r3, -0x80]
L_8cec8e:
	extb_s r0,r0
L_8cec90:
	st r0,[r3, -0x7c]
L_8cec94:
	b L_8c033c
