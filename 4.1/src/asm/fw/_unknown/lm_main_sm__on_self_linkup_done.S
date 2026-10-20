/* lm_main_sm__on_self_linkup_done @ 0x8d7c14, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: lm__notify_linkup, lm_main_sm__inject_conn_evt3
 */
	.section .text.lm_main_sm__on_self_linkup_done,"ax",@progbits
	.global lm_main_sm__on_self_linkup_done
lm_main_sm__on_self_linkup_done:
L_8d7c14:
	push_s blink
L_8d7c16:
	ld_s r3,[r0,0x30]
L_8d7c18:
	mov_s r1,0x0
L_8d7c1a:
	ld_s r2,[r0,0x2c]
L_8d7c1c:
	breq_s r3,0,L_8d7c28
L_8d7c1e:
	st_s r1,[r0,0x30]
L_8d7c20:
	bl.d L_8e30c4
L_8d7c24:
	mov_s r0,r2
L_8d7c26:
	b_s L_8d7c2e
	.global L_8d7c28
L_8d7c28:
	bl.d L_8d7d0c
L_8d7c2c:
	mov_s r0,r2
	.global L_8d7c2e
L_8d7c2e:
	pop_s blink
