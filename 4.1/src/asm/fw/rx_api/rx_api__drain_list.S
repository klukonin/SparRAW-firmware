/* rx_api__drain_list @ 0x8dee30, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_api.cpp
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/rx_api.h
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, llist__init, llist__pop_front, tail_fwq_tx__handle_completion, tail_rx_pkt_srvs__dispatch
 */
	.section .text.rx_api__drain_list,"ax",@progbits
	.global rx_api__drain_list
rx_api__drain_list:
L_8dee30:
	push_s blink
L_8dee32:
	bl L_8c02c0
L_8dee36:
	sub_s sp,sp,0x18
L_8dee38:
	brne r0,0x4,L_8dee52
	.global L_8dee3c
L_8dee3c:
	mov_s r15,sp
L_8dee3e:
	bl.d L_8de5c4
L_8dee42:
	mov_s r0,r15
L_8dee44:
	mov_s r0,0x8062c4
L_8dee4a:
	bl.d L_8ca538
L_8dee4e:
	mov_s r1,r15
L_8dee50:
	b_s L_8deec0
	.global L_8dee52
L_8dee52:
	mov_s r0,blink
L_8dee54:
	mov_s r2,0x1015304
L_8dee5a:
	mov_s r1,0x1215
L_8dee60:
	bl.d L_8c82c0
L_8dee64:
	mov_s r3,0x64
L_8dee66:
	b_s L_8dee3c
	.global L_8dee68
L_8dee68:
	bl.d L_8de2d4
L_8dee6c:
	mov_s r0,r15
L_8dee6e:
	mov.f r13,r0
L_8dee72:
	add_s r14,sp,0xc
L_8dee74:
	beq_s L_8deea6
	.global L_8dee76
L_8dee76:
	st_s r13,[r14]
L_8dee78:
	add r0,r13,0x28
L_8dee7c:
	st_s r0,[r14,0x8]
L_8dee7e:
	add r0,r13,0x38
L_8dee82:
	st_s r0,[r14,0x4]
L_8dee84:
	ldb r0,[r13, 0x34]
L_8dee88:
	cmp_s r0,0x0
L_8dee8a:
	cmp.ne r0,0x1
L_8dee8e:
	beq_s L_8deeba
L_8dee90:
	mov_s r0,blink
L_8dee92:
	mov_s r2,0x1015304
L_8dee98:
	mov_s r1,0x1216
L_8dee9e:
	bl.d L_8c82c0
L_8deea2:
	mov_s r3,0x7a
L_8deea4:
	b_s L_8deec0
	.global L_8deea6
L_8deea6:
	mov_s r0,blink
L_8deea8:
	mov_s r2,0x10152d0
L_8deeae:
	mov_s r1,0x1
L_8deeb0:
	bset_s r1,r1,0xc
L_8deeb2:
	bl.d L_8c82c0
L_8deeb6:
	mov_s r3,0x2a
L_8deeb8:
	b_s L_8dee76
	.global L_8deeba
L_8deeba:
	bl.d L_8deecc
L_8deebe:
	mov_s r0,r13
	.global L_8deec0
L_8deec0:
	ld_s r0,[sp,0x0]
L_8deec2:
	brne_s r0,0,L_8dee68
L_8deec4:
	b.d L_8c032c
L_8deec8:
	add_s sp,sp,0x18
L_8deeca:
	nop_s
