/* p2p_cfg @ 0x8ee994, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   p2p_cfg()
 * Зовут его: l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, find_mngr__cfg_offload, fw_log__emit0
 */
	.section .text.p2p_cfg,"ax",@progbits
	.global p2p_cfg
p2p_cfg:
	.global L_8ee994
L_8ee994:
	push_s blink
L_8ee996:
	bl L_8c02b8
L_8ee99a:
	mov_s r14,r0
L_8ee99c:
	mov_s r17,r1
L_8ee99e:
	mov_s r13,r2
L_8ee9a0:
	mov_s r16,r3
L_8ee9a2:
	mov_s r15,r4
L_8ee9a4:
	mov_s r2,0x1012818
L_8ee9aa:
	mov_s r0,0xc
L_8ee9ac:
	bl.d L_8edfb0
L_8ee9b0:
	mov_s r1,0x2
L_8ee9b2:
	add r0,r14,0xc
L_8ee9b6:
	extb_s r3,r13
L_8ee9b8:
	ld_s r1,[r14,0x4]
L_8ee9ba:
	mov_s r2,r17
L_8ee9bc:
	mov r4,r16
L_8ee9c0:
	bl.d L_8c5df4
L_8ee9c4:
	mov_s r5,r15
L_8ee9c6:
	b L_8c031c
L_8ee9ca:
	nop_s
