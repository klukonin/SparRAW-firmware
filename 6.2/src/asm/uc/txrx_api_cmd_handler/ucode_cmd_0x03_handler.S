/* ucode_cmd_0x03_handler @ 0x93a9d0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: bi__latch_tsf_and_reset, uc_send_evt_typed
 * Глобалы (через gp): 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x03_handler
ucode_cmd_0x03_handler:
	.global L_93a9d0
L_93a9d0:
	push_s blink
L_93a9d2:
	ldw.as r1,[gp,0x4a]
L_93a9d6:
	breq_s r1,0,L_93a9de
L_93a9d8:
	bl.d L_92b9d4
L_93a9dc:
	ld_s r0,[r0]
	.global L_93a9de
L_93a9de:
	mov_s r0,0x3
L_93a9e0:
	bl.d L_927928
L_93a9e4:
	mov_s r1,0x0
L_93a9e6:
	pop_s blink
L_93a9e8:
	j_s [blink]
L_93a9ea:
	nop_s
