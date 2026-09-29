/* hwf__rladder_calibrate @ 0x8d4944, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf__rf_lo_setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwf_rladder_scan
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf__rladder_calibrate
hwf__rladder_calibrate:
	.global L_8d4944
L_8d4944:
	push_s blink
L_8d4946:
	bl.d L_8c01e4
L_8d494a:
	mov_s r1,0xff
L_8d494c:
	mov_s r14,r0
L_8d494e:
	mov_s r0,0x0
L_8d4950:
	bl.d L_8c14f0
L_8d4954:
	mov_s r2,r14
L_8d4956:
	mov_s r13,r0
L_8d4958:
	add_s r0,r0,0x70
L_8d495a:
	lsr_s r0,r0,0x5
L_8d495c:
	cmp_s r0,0x20
L_8d495e:
	mov_s r1,0x20
L_8d4960:
	mov.cs r1,r0
L_8d4964:
	extb_s r1,r1
L_8d4966:
	mov_s r0,0x1
L_8d4968:
	bl.d L_8c14f0
L_8d496c:
	mov_s r2,r14
L_8d496e:
	add_s r0,r0,r13
L_8d4970:
	b.d L_8c0254
L_8d4974:
	lsr_s r0,r0
L_8d4976:
	nop_s
