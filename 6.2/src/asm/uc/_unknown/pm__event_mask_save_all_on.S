/* pm__event_mask_save_all_on @ 0x92dc6c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__open_event_mask
 * Зовёт сам: __ld_r13_to_r13_ret, mac__rf_switch_cmd1f
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global pm__event_mask_save_all_on
pm__event_mask_save_all_on:
	.global L_92dc6c
L_92dc6c:
	push_s blink
L_92dc6e:
	push_s r13
L_92dc70:
	mov_s r1,0x80146c
L_92dc76:
	ld_s r0,[r1,0x8]
L_92dc78:
	st_s r0,[r1,0xc]
L_92dc7a:
	mov r0,-0x1
L_92dc7e:
	st_s r0,[r1,0x8]
L_92dc80:
	lr r13,[0xa]
L_92dc84:
	bclr r0,r13,0x1
L_92dc88:
	flag r0
L_92dc8c:
	ld_s r0,[gp,-0xd4]
L_92dc8e:
	mov_s r1,0x80146c
L_92dc94:
	ld_s r1,[r1,0x8]
L_92dc96:
	and_s r0,r0,r1
L_92dc98:
	bset_s r0,r0,0x1b
L_92dc9a:
	mov_s r32,r0
L_92dc9c:
	st.ab r0,[r25,0x4]
L_92dca0:
	bclr r25,r25,0xa
L_92dca4:
	bl.d L_92c5e4
L_92dca8:
	mov_s r0,0x1
L_92dcaa:
	lr r0,[0xa]
L_92dcae:
	bic r13,r13,-0x3
L_92dcb2:
	or_s r13,r13,r0
L_92dcb4:
	flag r13
L_92dcb8:
	b L_9202ac
