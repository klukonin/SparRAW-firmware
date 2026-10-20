/* tx_api__tx_complete_cb @ 0x8e4a64, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW TX MGMT:tx_complete_cb  m_cur_metadata_p=0x%x, metadata_p=0x%x, p_conn=0x%x.
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   sw_tx_mgmt.cpp
 * Зовёт сам: SW_TX_MGMT_API__packet_release, __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit3, fw_sysassert_fatal, set_g_8000c0_x2
 * Глобалы (через gp): 0x80017c
 */
	.section .text.tx_api__tx_complete_cb,"ax",@progbits
	.global tx_api__tx_complete_cb
tx_api__tx_complete_cb:
L_8e4a64:
	push_s blink
L_8e4a66:
	bl L_8c02b8
L_8e4a6a:
	sub_s sp,sp,0x8
L_8e4a6c:
	mov.f r13,r0
L_8e4a70:
	mov_s r15,r1
L_8e4a72:
	mov_s r16,r2
L_8e4a74:
	mov_s r14,sp
L_8e4a76:
	beq_s L_8e4ad2
	.global L_8e4a78
L_8e4a78:
	st_s r13,[r14,0x4]
L_8e4a7a:
	sub r0,r13,0x1c
L_8e4a7e:
	st_s r0,[r14]
L_8e4a80:
	ld r17,[sp]
L_8e4a84:
	mov_s r2,0x1015648
L_8e4a8a:
	mov_s r0,0x7
L_8e4a8c:
	mov_s r1,0x2
L_8e4a8e:
	ld.as r3,[gp,-0x2c]
L_8e4a92:
	mov r4,r17
L_8e4a96:
	bl.d L_8ee034
L_8e4a9a:
	mov r5,r16
L_8e4a9e:
	ld_s r0,[gp,-0xb0]
L_8e4aa0:
	brne r0,r17,L_8e4ae8
	.global L_8e4aa4
L_8e4aa4:
	mov.f r1,r15
L_8e4aa8:
	mov.ne r1,0x1
L_8e4aac:
	asl_s r1,r1
L_8e4aae:
	ld r2,[r16, 0xc]
L_8e4ab2:
	mov_s r0,r13
L_8e4ab4:
	ldb_s r2,[r2,0x10]
L_8e4ab6:
	bl.d L_8db394
L_8e4aba:
	ld.as r3,[gp,0x3]
L_8e4abe:
	mov_s r0,0x0
L_8e4ac0:
	stb r0,[r16, 0x40]
L_8e4ac4:
	bl.d L_8de5b8
L_8e4ac8:
	st r0,[r16, 0x3c]
L_8e4acc:
	b.d L_8c031c
L_8e4ad0:
	add_s sp,sp,0x8
	.global L_8e4ad2
L_8e4ad2:
	mov_s r0,blink
L_8e4ad4:
	mov_s r2,0x10153e0
L_8e4ada:
	mov_s r1,0x11e9
L_8e4ae0:
	bl.d L_8c82c0
L_8e4ae4:
	mov_s r3,0xab
L_8e4ae6:
	b_s L_8e4a78
	.global L_8e4ae8
L_8e4ae8:
	mov_s r0,blink
L_8e4aea:
	mov_s r2,0x10154e8
L_8e4af0:
	mov_s r1,0x121a
L_8e4af6:
	bl.d L_8c82c0
L_8e4afa:
	mov_s r3,0x9d
L_8e4afc:
	b_s L_8e4aa4
L_8e4afe:
	nop_s
