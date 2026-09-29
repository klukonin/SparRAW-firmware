/* mac_parser__configure @ 0x8ee9cc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_mac_parser__build_desc, mac_parser__init, mac_parser__set_886200, mac_parser__set_886260
 * Глобалы (через gp): 0x80044c
 */
	.section .text.mac_parser__configure,"ax",@progbits
	.global mac_parser__configure
mac_parser__configure:
	.global L_8ee9cc
L_8ee9cc:
	push_s blink
L_8ee9ce:
	bl L_8c02c4
L_8ee9d2:
	mov_s r14,r1
L_8ee9d4:
	ld.as r1,[gp,0xb7]
L_8ee9d8:
	cmp_s r1,0x0
L_8ee9da:
	mov.ne r13,r14
L_8ee9de:
	bl.d L_8db698
L_8ee9e2:
	mov.eq r13,0x1
L_8ee9e6:
	mov_s r0,0x1
L_8ee9e8:
	mov_s r1,0x0
L_8ee9ea:
	bl.d L_8db8e8
L_8ee9ee:
	mov_s r2,0x7
L_8ee9f0:
	mov_s r0,0x2
L_8ee9f2:
	mov_s r1,0x0
L_8ee9f4:
	bl.d L_8db8e8
L_8ee9f8:
	mov_s r2,0x3f
L_8ee9fa:
	mov_s r1,0x4102
L_8eea00:
	bl.d L_8dbae4
L_8eea04:
	mov_s r0,0x1
L_8eea06:
	mov_s r0,0x3
L_8eea08:
	bl.d L_8dbae4
L_8eea0c:
	mov r1,0x102
L_8eea10:
	mov_s r0,r13
L_8eea12:
	mov_s r1,r14
L_8eea14:
	mov_s r2,r14
L_8eea16:
	mov_s r3,r14
L_8eea18:
	bl.d L_8dbac8
L_8eea1c:
	mov_s r4,r14
L_8eea1e:
	.byte 0x19,0x01
