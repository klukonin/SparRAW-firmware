/* state_sm_803424__action_8f0750 @ 0x8f0750, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f0750
state_sm_803424__action_8f0750:
	.global L_8f0750
L_8f0750:
	push_s blink
L_8f0752:
	push_s r13
L_8f0754:
	mov_s r13,r0
L_8f0756:
	ld.as r1,[gp,-0x3e]
L_8f075a:
	mov_s r0,L_8f3254-0x8c0000
L_8f0760:
	mulu64 r1,0x3e8
L_8f0764:
	ld_s r1,[r13,0x10]
L_8f0766:
	mov_s r2,0x2
L_8f0768:
	mov_s r3,0x1
L_8f076a:
	mov r4,mlo
L_8f076e:
	mov r5,0x0
L_8f0772:
	bl.d L_8e0c0c
L_8f0776:
	mov r6,r5
L_8f077a:
	b.d L_8c025c
L_8f077e:
	st_s r0,[r13,0xc]
