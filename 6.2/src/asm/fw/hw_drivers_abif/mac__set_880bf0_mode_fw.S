/* mac__set_880bf0_mode_fw @ 0x8d0144, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_880bf0_mode_fw
mac__set_880bf0_mode_fw:
	.global L_8d0144
L_8d0144:
	push_s blink
L_8d0146:
	push_s r13
L_8d0148:
	brhs.d r0,0x5,L_8d0160
L_8d014c:
	mov_s r13,r0
L_8d014e:
	ldb.x r10,[0x803958,r13]
L_8d0156:
	add r0,pcl,0xc
L_8d015a:
	add1 r0,r0,r10
L_8d015e:
	j_s [r0]
	.global L_8d0160
L_8d0160:
	mov_s r0,blink
L_8d0162:
	mov_s r1,0x12d7
L_8d0168:
	bl L_8c9b28
L_8d016c:
	asl_s r1,r13,0x4
L_8d016e:
	mov_s r2,0x880b80
L_8d0174:
	ld_s r0,[r2,0x70]
L_8d0176:
	or_s r1,r1,r13
L_8d0178:
	bic r0,r0,0xff
L_8d017c:
	extb_s r1,r1
L_8d017e:
	or_s r0,r0,r1
L_8d0180:
	st_s r0,[r2,0x70]
L_8d0182:
	b L_8c025c
L_8d0186:
	nop_s
