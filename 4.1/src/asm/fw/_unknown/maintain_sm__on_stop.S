/* maintain_sm__on_stop @ 0x8f16e0, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, maintain_sm__release_radio_after_bf_evt, maintain_sm__reset_link_cfg, u_schd__cancel
 */
	.section .text.maintain_sm__on_stop,"ax",@progbits
	.global maintain_sm__on_stop
maintain_sm__on_stop:
L_8f16e0:
	push_s blink
L_8f16e2:
	bl L_8c02c4
L_8f16e6:
	mov_s r13,r0
L_8f16e8:
	mov_s r14,0x0
L_8f16ea:
	bl.d L_8eaf88
L_8f16ee:
	st.as r14,[gp,-0x1b]
L_8f16f2:
	ld_s r0,[r13,0x40]
L_8f16f4:
	breq_s r0,0,L_8f16fc
L_8f16f6:
	bl L_8c7794
L_8f16fa:
	st_s r14,[r13,0x40]
	.global L_8f16fc
L_8f16fc:
	ld_s r0,[r13,0x44]
L_8f16fe:
	breq_s r0,0,L_8f1706
L_8f1700:
	bl L_8c7794
L_8f1704:
	st_s r14,[r13,0x44]
	.global L_8f1706
L_8f1706:
	bl.d L_8de158
L_8f170a:
	mov_s r0,r13
L_8f170c:
	add3 r0,r13,0xa
L_8f1710:
	mov_s r1,0x3
L_8f1712:
	mov_s r2,0x0
L_8f1714:
	mov_s r3,r2
L_8f1716:
	bl.d L_8d6a1c
L_8f171a:
	mov_s r4,r2
L_8f171c:
	ld_s r0,[r13,0x2c]
L_8f171e:
	mov_s r1,0x8
L_8f1720:
	mov_s r2,0x0
L_8f1722:
	mov_s r3,r2
L_8f1724:
	bl.d L_8d6a1c
L_8f1728:
	mov_s r4,r2
L_8f172a:
	.byte 0x0d,0x04
