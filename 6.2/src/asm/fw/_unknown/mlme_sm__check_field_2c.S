/* mlme_sm__check_field_2c @ 0x8c6888, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r13_to_r13_ret, mem_pool__free_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__check_field_2c
mlme_sm__check_field_2c:
	.global L_8c6888
L_8c6888:
	push_s blink
L_8c688a:
	push_s r13
L_8c688c:
	mov_s r13,r0
L_8c688e:
	ld_s r0,[r0,0x2c]
L_8c6890:
	breq_s r0,0,L_8c689a
L_8c6892:
	bl L_8cb15c
L_8c6896:
	mov_s r0,0x0
L_8c6898:
	st_s r0,[r13,0x2c]
	.global L_8c689a
L_8c689a:
	b L_8c025c
L_8c689e:
	nop_s
