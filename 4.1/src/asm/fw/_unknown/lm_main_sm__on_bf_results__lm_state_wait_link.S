/* lm_main_sm__on_bf_results__lm_state_wait_link @ 0x8dd054, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__store_pending_event, stub_ret_8c3f1c
 */
	.section .text.lm_main_sm__on_bf_results__lm_state_wait_link,"ax",@progbits
	.global lm_main_sm__on_bf_results__lm_state_wait_link
lm_main_sm__on_bf_results__lm_state_wait_link:
L_8dd054:
	push_s blink
L_8dd056:
	mov_s r3,r0
L_8dd058:
	ld_s r0,[r1,0xc]
L_8dd05a:
	mov_s r2,r1
L_8dd05c:
	breq_s r0,0,L_8dd070
L_8dd05e:
	mov_s r0,r3
L_8dd060:
	bl.d L_8c3f1c
L_8dd064:
	mov_s r1,r3
L_8dd066:
	cmp_s r0,0x0
L_8dd068:
	mov.ne r0,r3
L_8dd06c:
	mov_s r1,0x2
L_8dd06e:
	bne_s L_8dd074
	.global L_8dd070
L_8dd070:
	mov_s r0,r3
L_8dd072:
	mov_s r1,0x1
	.global L_8dd074
L_8dd074:
	mov_s r2,0x0
L_8dd076:
	mov_s r3,r2
L_8dd078:
	bl.d L_8e20c0
L_8dd07c:
	mov_s r4,r2
L_8dd07e:
	pop_s blink
L_8dd080:
	j_s [blink]
L_8dd082:
	nop_s
