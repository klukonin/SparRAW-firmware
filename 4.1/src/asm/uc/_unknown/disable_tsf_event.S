/* disable_tsf_event @ 0x925120, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   disable_tsf_event()
 * Зовут его: ucode_cmd__bi_config
 */
	.section .text.disable_tsf_event,"ax",@progbits
	.global disable_tsf_event
disable_tsf_event:
	.global L_925120
L_925120:
	push_s r13
L_925122:
	mov r4,0x80209c
L_92512a:
	ldb r0,[r4, 0x4]
L_92512e:
	mov_s r2,0x1000d9c
L_925134:
	bbit0.d r0,0x2,L_925160
L_925138:
	mov_s r13,blink
L_92513a:
	bmsk_s r2,r2,0x13
L_92513c:
	ld r1,[r4]
L_925140:
	or r2,r2,0xa2000000
L_925148:
	extb r5,r1
L_92514c:
	mov_s r3,0x8020b0
L_925152:
	add2 r3,r3,r5
L_925156:
	st_s r2,[r3]
L_925158:
	add r1,r1,0x1
L_92515c:
	st r1,[r4]
	.global L_925160
L_925160:
	mov_s r3,0x887000
L_925166:
	st.as 0xc0010,[r3,-0xb2]
L_92516e:
	mov_s r2,0x40
L_925170:
	bset_s r2,r2,0x19
L_925172:
	mov_s r32,r2
L_925174:
	st.ab r2,[r25,0x4]
L_925178:
	bclr r25,r25,0xa
L_92517c:
	mov_s blink,r13
L_92517e:
	j_s.d [blink]
L_925180:
	pop_s r13
L_925182:
	nop_s
