/* l2mgr__apply_key_to_prings @ 0x8fa7f8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: return_field_type
 * Зовёт сам: __ld_r13_to_r13_ret, conn__sm_handle_event, vring__reinstall_keys_for_mid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__apply_key_to_prings
l2mgr__apply_key_to_prings:
	.global L_8fa7f8
L_8fa7f8:
	push_s blink
L_8fa7fa:
	push_s r13
L_8fa7fc:
	mov_s r13,r0
L_8fa7fe:
	bl.d L_8ea7ac
L_8fa802:
	mov_s r1,0x0
L_8fa804:
	mov_s r0,r13
L_8fa806:
	mov_s r1,0x5
L_8fa808:
	mov_s r2,0x0
L_8fa80a:
	mov_s r3,0x0
L_8fa80c:
	bl.d L_8d9cc0
L_8fa810:
	mov r4,0x0
L_8fa814:
	b L_8c025c
