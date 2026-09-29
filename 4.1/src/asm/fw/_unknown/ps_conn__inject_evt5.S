/* ps_conn__inject_evt5 @ 0x8dd1f4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_conn_mgr__notify_all
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.ps_conn__inject_evt5,"ax",@progbits
	.global ps_conn__inject_evt5
ps_conn__inject_evt5:
	.global L_8dd1f4
L_8dd1f4:
	mov_s r2,0x0
L_8dd1f6:
	st.ab r2,[r0,0x4]
L_8dd1fa:
	mov_s r1,0x5
L_8dd1fc:
	mov_s r3,r2
L_8dd1fe:
	b.d L_8d6a1c
L_8dd202:
	mov_s r4,r2
