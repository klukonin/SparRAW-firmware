/* bcon__refresh_dti_ie @ 0x8e5784, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps__on_awake_peers
 * Зовёт сам: __ld_r13_ret, fw_scheduled_dti__update_ie, mid__get_bcon_additional_ies
 */
	.section .text.bcon__refresh_dti_ie,"ax",@progbits
	.global bcon__refresh_dti_ie
bcon__refresh_dti_ie:
	.global L_8e5784
L_8e5784:
	push_s blink
L_8e5786:
	push_s r13
L_8e5788:
	mov_s r13,r0
L_8e578a:
	add_s r0,r0,0x48
L_8e578c:
	bl.d L_8c97fc
L_8e5790:
	mov_s r1,0x8
L_8e5792:
	mov_s r1,r0
L_8e5794:
	mov_s r0,r13
L_8e5796:
	bl.d L_8e5708
L_8e579a:
	add r0,r0,0x2b4
L_8e579e:
	b L_8c033c
L_8e57a2:
	nop_s
