/* link_up_evt @ 0x8dacec, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   link_up_evt: Sending EVT_FTM_START_SESSION
 * Зовут его: WBE_DRIVER__link_down_notif
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_up_evt
link_up_evt:
	.global L_8dacec
L_8dacec:
	push_s blink
L_8dacee:
	push_s r13
L_8dacf0:
	brne_s r1,0,L_8dad18
L_8dacf2:
	mov_s r13,0x806518
L_8dacf8:
	ldb_s r0,[r13]
L_8dacfa:
	brne r0,0x4,L_8dad18
L_8dacfe:
	mov_s r1,0x1019aec
L_8dad04:
	bl.d L_8dcba8
L_8dad08:
	mov_s r0,0x27
L_8dad0a:
	mov_s r0,r13
L_8dad0c:
	mov_s r1,0x0
L_8dad0e:
	mov_s r2,r1
L_8dad10:
	mov_s r3,r1
L_8dad12:
	bl.d L_8d9b6c
L_8dad16:
	mov_s r4,r1
	.global L_8dad18
L_8dad18:
	b L_8c025c
