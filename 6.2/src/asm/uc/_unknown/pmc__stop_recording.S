/* pmc__stop_recording @ 0x936134, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: handle_pmc_triggers, txrx_umac_if_config_pmc_triggers_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global pmc__stop_recording
pmc__stop_recording:
	.global L_936134
L_936134:
	push_s blink
L_936136:
	mov_s r1,0x886000
L_93613c:
	ld_s r0,[r1,0x7c]
L_93613e:
	bmsk_s r0,r0,0x17
L_936140:
	st_s r0,[r1,0x7c]
L_936142:
	mov_s r0,0x50
L_936144:
	mov lp_count,r0
L_936148:
	nop_s
L_93614a:
	lp L_936152
L_93614e:
	nop_s
L_936150:
	nop_s
	.global L_936152
L_936152:
	mov_s r0,0x50
L_936154:
	mov lp_count,r0
L_936158:
	nop_s
L_93615a:
	lp L_936162
L_93615e:
	nop_s
L_936160:
	nop_s
	.global L_936162
L_936162:
	mov_s r0,0x50
L_936164:
	mov lp_count,r0
L_936168:
	nop_s
L_93616a:
	lp L_936172
L_93616e:
	nop_s
L_936170:
	nop_s
	.global L_936172
L_936172:
	mov_s r1,0x886000
L_936178:
	ld_s r0,[r1,0x7c]
L_93617a:
	bset_s r0,r0,0x11
L_93617c:
	st_s r0,[r1,0x7c]
L_93617e:
	pop_s blink
L_936180:
	j_s [blink]
L_936182:
	nop_s
