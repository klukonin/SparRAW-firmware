/* ucode_cmd_update_aw_ie @ 0x9357e4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_api_cmd_handler.c
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: aw_ie__copy_to_bcon, uc_sysassert
 */
	.section .text.ucode_cmd_update_aw_ie,"ax",@progbits
	.global ucode_cmd_update_aw_ie
ucode_cmd_update_aw_ie:
	.global L_9357e4
L_9357e4:
	push_s blink
L_9357e6:
	ld_s r1,[r0]
L_9357e8:
	cmp r1,0x9d
L_9357ec:
	beq_s L_935802
L_9357ee:
	mov_s r0,blink
L_9357f0:
	mov_s r2,0x1001830
L_9357f6:
	mov_s r1,0x84
L_9357f8:
	bl.d L_925548
L_9357fc:
	mov r3,0x1fc
L_935800:
	b_s L_935810
	.global L_935802
L_935802:
	mov_s r2,0x801ed0
L_935808:
	add_s r1,r0,0x4
L_93580a:
	bl.d L_930420
L_93580e:
	mov_s r0,r2
	.global L_935810
L_935810:
	pop_s blink
L_935812:
	j_s [blink]
