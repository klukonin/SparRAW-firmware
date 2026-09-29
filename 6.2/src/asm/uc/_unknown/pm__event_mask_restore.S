/* pm__event_mask_restore @ 0x92dcd8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pm__wake_sequence
 * Зовёт сам: __ld_r13_to_r13_ret, mac__rf_switch_cmd1f
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global pm__event_mask_restore
pm__event_mask_restore:
	.global L_92dcd8
L_92dcd8:
	push_s blink
L_92dcda:
	push_s r13
L_92dcdc:
	mov_s r1,0x80146c
L_92dce2:
	ld_s r0,[r1]
L_92dce4:
	bbit0 r0,0x0,L_92dd1e
L_92dce8:
	ld_s r0,[r1,0xc]
L_92dcea:
	st_s r0,[r1,0x8]
L_92dcec:
	lr r13,[0xa]
L_92dcf0:
	bclr r0,r13,0x1
L_92dcf4:
	flag r0
L_92dcf8:
	ld_s r0,[gp,-0xd4]
L_92dcfa:
	ld_s r1,[r1,0x8]
L_92dcfc:
	and_s r0,r0,r1
L_92dcfe:
	bset_s r0,r0,0x1b
L_92dd00:
	mov_s r32,r0
L_92dd02:
	st.ab r0,[r25,0x4]
L_92dd06:
	bclr r25,r25,0xa
L_92dd0a:
	bl.d L_92c5e4
L_92dd0e:
	mov_s r0,0x1
L_92dd10:
	lr r0,[0xa]
L_92dd14:
	bic r13,r13,-0x3
L_92dd18:
	or_s r13,r13,r0
L_92dd1a:
	flag r13
	.global L_92dd1e
L_92dd1e:
	mov r1,-0x1
L_92dd22:
	mov_s r0,0x80146c
L_92dd28:
	b.d L_9202ac
L_92dd2c:
	st_s r1,[r0,0xc]
L_92dd2e:
	nop_s
