/* find_mngr__listen_end @ 0x8daff0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: state_sm_8030f4__action_8f96a8, state_sm_8030f4__action_8f9ce0
 * Зовёт сам: l2mgr__send_listen_started
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__listen_end
find_mngr__listen_end:
	.global L_8daff0
L_8daff0:
	push_s blink
L_8daff2:
	ld_s r1,[r0,0xc]
L_8daff4:
	brne_s r1,0,L_8db000
L_8daff6:
	ld_s r1,[r0,0x48]
L_8daff8:
	mov_s r0,0x0
L_8daffa:
	bl.d L_8f89a4
L_8daffe:
	ldb_s r1,[r1,0x10]
	.global L_8db000
L_8db000:
	pop_s blink
L_8db002:
	j_s [blink]
