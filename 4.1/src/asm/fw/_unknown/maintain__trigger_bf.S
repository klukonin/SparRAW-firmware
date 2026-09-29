/* maintain__trigger_bf @ 0x8c5014, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: lm__get_cid, lmac_if_trigger_bf
 */
	.section .text.maintain__trigger_bf,"ax",@progbits
	.global maintain__trigger_bf
maintain__trigger_bf:
L_8c5014:
	/* b_s 0x008c4faa */
	.byte 0xcb,0xf1
	.global sub_8c5016
sub_8c5016:
L_8c5016:
	nop_s
L_8c5018:
	push_s blink
L_8c501a:
	ld_s r0,[r1,0x48]
L_8c501c:
	breq_s r0,0,L_8c5030
L_8c501e:
	mov_s r0,0x1
L_8c5020:
	st_s r0,[r1,0x4c]
L_8c5022:
	bl.d L_8c9d74
L_8c5026:
	ld_s r0,[r1,0x2c]
L_8c5028:
	extb_s r0,r0
L_8c502a:
	bl.d L_8d8cb0
L_8c502e:
	mov_s r1,0x0
	.global L_8c5030
L_8c5030:
	pop_s blink
L_8c5032:
	j_s [blink]
