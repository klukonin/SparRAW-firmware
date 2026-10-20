/* stream__inject_evt1 @ 0x8e3250, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR, connection__dec_stream_count
 * Зовёт сам: conn_sm__inject_event
 */
	.section .text.stream__inject_evt1,"ax",@progbits
	.global stream__inject_evt1
stream__inject_evt1:
	.global L_8e3250
L_8e3250:
	mov_s r1,0x1
L_8e3252:
	mov_s r2,0x0
L_8e3254:
	mov_s r3,r2
L_8e3256:
	b.d L_8d6b78
L_8e325a:
	mov_s r4,r2
