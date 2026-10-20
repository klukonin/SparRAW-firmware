/* maintain_sm__init @ 0x8ed114, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_main_sm__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__setup, link_stats_sm__init, stub_ret_8c5a30
 * Глобалы (через gp): 0x800444
 */
	.section .text.maintain_sm__init,"ax",@progbits
	.global maintain_sm__init
maintain_sm__init:
	.global L_8ed114
L_8ed114:
	push_s blink
L_8ed116:
	bl.d L_8c02c0
L_8ed11a:
	mov r6,0xa
L_8ed11e:
	mov_s r14,r0
L_8ed120:
	mov_s r15,r1
L_8ed122:
	mov r4,0x801388
L_8ed12a:
	mov r5,0x8013b0
L_8ed132:
	ld.as r1,[gp,-0x5]
L_8ed136:
	mov_s r13,0x0
L_8ed138:
	mov_s r2,r13
L_8ed13a:
	mov_s r3,0x80287c
L_8ed140:
	bl.d L_8d6478
L_8ed144:
	mov r7,0x4
L_8ed148:
	add3 r0,r14,0xa
L_8ed14c:
	bl.d L_8d5bcc
L_8ed150:
	mov_s r1,r14
L_8ed152:
	mov_s r0,0x2
L_8ed154:
	st_s r0,[r14,0x30]
L_8ed156:
	mov_s r0,0x80345c
L_8ed15c:
	st_s r13,[r14,0x40]
L_8ed15e:
	st_s r13,[r14,0x44]
L_8ed160:
	st_s r13,[r14,0x48]
L_8ed162:
	st_s r13,[r14,0x4c]
L_8ed164:
	st_s r15,[r14,0x2c]
L_8ed166:
	ld_s r0,[r0,0x18]
L_8ed168:
	bbit0 r0,0x6,L_8ed176
L_8ed16c:
	st 0x2710,[r14, 0x38]
L_8ed174:
	b_s L_8ed17a
	.global L_8ed176
L_8ed176:
	ld_s r0,[gp,0x2d4]
L_8ed178:
	st_s r0,[r14,0x38]
	.global L_8ed17a
L_8ed17a:
	stb r13,[r14, 0x3d]
L_8ed17e:
	bl.d L_8c5a30
L_8ed182:
	mov_s r0,r14
L_8ed184:
	b L_8c032c
