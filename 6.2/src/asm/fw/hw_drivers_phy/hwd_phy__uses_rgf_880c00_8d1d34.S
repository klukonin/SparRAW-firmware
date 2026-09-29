/* hwd_phy__uses_rgf_880c00_8d1d34 @ 0x8d1d34, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__apply_power_mode, hwd_phy__power_up_seq
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_880c00_8d1d34
hwd_phy__uses_rgf_880c00_8d1d34:
	.global L_8d1d34
L_8d1d34:
	push_s blink
L_8d1d36:
	push_s r13
L_8d1d38:
	brhs.d r0,0x5,L_8d1d50
L_8d1d3c:
	mov_s r13,r0
L_8d1d3e:
	ldb.x r10,[0x8038ec,r13]
L_8d1d46:
	add r0,pcl,0xc
L_8d1d4a:
	add1 r0,r0,r10
L_8d1d4e:
	j_s [r0]
	.global L_8d1d50
L_8d1d50:
	mov_s r0,blink
L_8d1d52:
	mov_s r1,0x12da
L_8d1d58:
	bl L_8c9b28
L_8d1d5c:
	asl_s r1,r13,0x4
L_8d1d5e:
	or_s r1,r1,r13
L_8d1d60:
	asl r0,r13,0x8
L_8d1d64:
	or_s r0,r0,r1
L_8d1d66:
	asl r1,r13,0xc
L_8d1d6a:
	or_s r1,r1,r0
L_8d1d6c:
	asl r0,r13,0x10
L_8d1d70:
	or_s r0,r0,r1
L_8d1d72:
	asl r1,r13,0x14
L_8d1d76:
	or_s r1,r1,r0
L_8d1d78:
	asl r0,r13,0x18
L_8d1d7c:
	or_s r0,r0,r1
L_8d1d7e:
	asl_s r13,r13,0x1c
L_8d1d80:
	or_s r0,r0,r13
L_8d1d82:
	mov_s r1,0x880c00
L_8d1d88:
	st_s r0,[r1,0x4]
L_8d1d8a:
	bmsk_s r0,r0,0x1b
L_8d1d8c:
	st_s r0,[r1,0x8]
L_8d1d8e:
	b L_8c025c
L_8d1d92:
	nop_s
