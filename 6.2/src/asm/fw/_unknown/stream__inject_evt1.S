/* stream__inject_evt1 @ 0x8e8354, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR, stream_mgr__check_count_a
 * Зовёт сам: conn__sm_handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream__inject_evt1
stream__inject_evt1:
	.global L_8e8354
L_8e8354:
	mov_s r1,0x1
L_8e8356:
	mov_s r2,0x0
L_8e8358:
	mov_s r3,r2
L_8e835a:
	b.d L_8d9cc0
L_8e835e:
	mov_s r4,r2
