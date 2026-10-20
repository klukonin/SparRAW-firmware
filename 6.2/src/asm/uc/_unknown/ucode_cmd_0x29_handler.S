/* ucode_cmd_0x29_handler @ 0x936014, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x29_handler
ucode_cmd_0x29_handler:
	.global L_936014
L_936014:
	push_s blink
L_936016:
	bl L_920230
L_93601a:
	mov_s r14,r0
L_93601c:
	mov_s r15,r1
L_93601e:
	ld_s r1,[r14]
L_936020:
	mov_s r0,0x0
L_936022:
	brne r1,0x1,L_93602e
L_936026:
	ld_s r1,[r14,0xc]
L_936028:
	cmp_s r1,0x2
L_93602a:
	mov.eq r0,0x1
	.global L_93602e
L_93602e:
	extb.f 0x0,r0
L_936032:
	beq_s L_9360a0
L_936034:
	ld_s r0,[gp,-0x44]
L_936036:
	add r13,r14,0x18
L_93603a:
	and r0,r0,0xffff0fff
L_936042:
	bset r1,r0,0xc
L_936046:
	bset_s r1,r1,0xe
L_936048:
	st.as r1,[gp,-0x11]
L_93604c:
	or r0,r0,0x1d005000
L_936054:
	mov_s r32,r0
L_936056:
	st.ab r0,[r25,0x4]
L_93605a:
	bclr r25,r25,0xa
L_93605e:
	nop_s
L_936060:
	nop_s
L_936062:
	nop_s
L_936064:
	st r40,[r13]
L_936068:
	ld_s r0,[gp,-0x44]
L_93606a:
	and r0,r0,0xffff0fff
L_936072:
	bset r1,r0,0xd
L_936076:
	bset_s r1,r1,0xe
L_936078:
	or r0,r0,0x1d006000
L_936080:
	st.as r1,[gp,-0x11]
L_936084:
	mov_s r32,r0
L_936086:
	st.ab r0,[r25,0x4]
L_93608a:
	bclr r25,r25,0xa
L_93608e:
	nop_s
L_936090:
	nop_s
L_936092:
	nop_s
L_936094:
	st r40,[r13, 0x4]
L_936098:
	st_s r15,[r14,0xc]
L_93609a:
	bl.d L_9216f8
L_93609e:
	mov_s r0,0x0
	.global L_9360a0
L_9360a0:
	b L_92029c
