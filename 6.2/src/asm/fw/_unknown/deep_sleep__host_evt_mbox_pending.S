/* deep_sleep__host_evt_mbox_pending @ 0x8da608, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global deep_sleep__host_evt_mbox_pending
deep_sleep__host_evt_mbox_pending:
	.global L_8da608
L_8da608:
	mov_s r0,0x8802bc
L_8da60e:
	ld_s r1,[r0,0x18]
L_8da610:
	ld_s r0,[r0,0x1c]
L_8da612:
	rsub.f r0,r0,r1
L_8da616:
	j_s.d [blink]
L_8da618:
	mov.ne r0,0x1
