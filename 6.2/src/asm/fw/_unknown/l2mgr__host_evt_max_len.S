/* l2mgr__host_evt_max_len @ 0x8cc3c8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__send_host_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__host_evt_max_len
l2mgr__host_evt_max_len:
	.global L_8cc3c8
L_8cc3c8:
	j_s.d [blink]
L_8cc3ca:
	mov_s r0,0xf0
