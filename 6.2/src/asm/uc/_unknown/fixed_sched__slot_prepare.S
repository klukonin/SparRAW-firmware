/* fixed_sched__slot_prepare @ 0x925b50, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state4
 * Зовёт сам: __ld_r13_to_r13_ret, dump_mac_buffer_bases, macq__flush_queue, macq__is_idle, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__slot_prepare
fixed_sched__slot_prepare:
	.global L_925b50
L_925b50:
	push_s blink
L_925b52:
	push_s r13
L_925b54:
	mov_s r13,r0
L_925b56:
	bl.d L_925b7c
L_925b5a:
	mov_s r2,r0
L_925b5c:
	bl.d L_92609c
L_925b60:
	mov_s r0,r13
L_925b62:
	brne_s r0,0,L_925b78
L_925b64:
	mov_s r0,r13
L_925b66:
	bl.d L_925c0c
L_925b6a:
	mov_s r1,r13
L_925b6c:
	mov_s r0,blink
L_925b6e:
	mov_s r1,0x157b
L_925b74:
	bl L_926618
	.global L_925b78
L_925b78:
	b L_9202ac
