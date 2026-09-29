/* ba__schedule_timeout_update @ 0x8ead48, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba__on_uc_timeout_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__add, vring_tbl__ptr_by_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba__schedule_timeout_update
ba__schedule_timeout_update:
	.global L_8ead48
L_8ead48:
	push_s blink
L_8ead4a:
	bl L_8c01e4
L_8ead4e:
	mov_s r13,r0
L_8ead50:
	mov_s r14,r2
L_8ead52:
	brne_s r1,0,L_8ead6c
L_8ead54:
	bl L_8cce84
L_8ead58:
	stw r14,[r0, 0x5c]
L_8ead5c:
	mov_s r0,L_8e23a4-0x8c0000
L_8ead62:
	mov_s r1,r13
L_8ead64:
	mov_s r2,0x0
L_8ead66:
	bl.d L_8c3248
L_8ead6a:
	mov_s r3,0x1
	.global L_8ead6c
L_8ead6c:
	b L_8c0254
