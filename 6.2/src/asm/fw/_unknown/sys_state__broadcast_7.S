/* sys_state__broadcast_7 @ 0x8f2790, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__start_disc_8e797c
 * Зовёт сам: sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sys_state__broadcast_7
sys_state__broadcast_7:
	.global L_8f2790
L_8f2790:
	ldb_s r1,[r0,0x8]
L_8f2792:
	b.d L_8e8a14
L_8f2796:
	mov_s r0,0x7
