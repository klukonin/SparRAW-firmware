/* stream_mgr__reset_vring_thunk @ 0x8e292c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD
 * Зовёт сам: hwd_dma__reset_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__reset_vring_thunk
stream_mgr__reset_vring_thunk:
	.global L_8e292c
L_8e292c:
	b L_8d09a0
