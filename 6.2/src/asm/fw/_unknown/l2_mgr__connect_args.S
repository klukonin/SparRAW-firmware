/* l2_mgr__connect_args @ 0x8dca38, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect, maintain_sm__lock_radio, mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__connect_args
l2_mgr__connect_args:
	.global L_8dca38
L_8dca38:
	push_s blink
L_8dca3a:
	push_s r13
L_8dca3c:
	mov_s r5,r0
L_8dca3e:
	mov_s r4,r1
L_8dca40:
	ld_s r0,[gp,-0x40]
L_8dca42:
	mov_s r3,r2
L_8dca44:
	ld_s r1,[r0]
L_8dca46:
	ld_s r13,[r1,0x8]
L_8dca48:
	mov_s r1,r5
L_8dca4a:
	jl_s.d [r13]
L_8dca4c:
	mov_s r2,r4
L_8dca4e:
	b L_8c025c
L_8dca52:
	nop_s
