/* tx_slot__dispatch @ 0x938e34, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__run_tx_slot
 * Зовёт сам: __ld_r13_to_r13_ret, bi_tx__check_idle_and_start_uc, internal_tx_isr, mac__select_all_sectors_and_wait, tx_bcast_flow, tx_ctx__alloc_next, tx_slot__pick_queue, tx_sta__run_txop
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_slot__dispatch
tx_slot__dispatch:
	.global L_938e34
L_938e34:
	push_s blink
L_938e36:
	push_s r13
L_938e38:
	sub_s sp,sp,0x4
L_938e3a:
	bl.d L_9384d4
L_938e3e:
	mov_s r0,0x1
L_938e40:
	mov_s r13,r0
L_938e42:
	mov_s r0,sp
L_938e44:
	bl.d L_9396f4
L_938e48:
	mov_s r1,0x1
L_938e4a:
	breq_s r0,0,L_938e78
L_938e4c:
	bl L_936870
L_938e50:
	mov_s r0,r42
L_938e52:
	bbit0 r0,0xe,L_938ea2
L_938e56:
	mov_s r1,0x8022c8
L_938e5c:
	ld_s r0,[r1,0x4]
L_938e5e:
	st.as 0x800,[gp,0x34]
L_938e66:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938e68:
	st_s r0,[r1,0x4]
L_938e6a:
	mov_s r1,0x8010b0
L_938e70:
	ld_s r0,[r1,0x44]
L_938e72:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938e74:
	st_s r0,[r1,0x44]
L_938e76:
	b_s L_938f08
	.global L_938e78
L_938e78:
	bl.d L_93696c
L_938e7c:
	mov_s r0,0x2
L_938e7e:
	mov_s r1,0x8022c8
L_938e84:
	ld_s r0,[r1,0x8]
L_938e86:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938e88:
	st_s r0,[r1,0x8]
L_938e8a:
	mov_s r0,0xeeee01
L_938e90:
	mov_s r32,r0
L_938e92:
	st.ab r0,[r25,0x4]
L_938e96:
	bclr r25,r25,0xa
L_938e9a:
	b_s L_938f08
	.global L_938e9c
L_938e9c:
	bl L_937844
L_938ea0:
	b_s L_938f08
	.global L_938ea2
L_938ea2:
	ld_s r1,[sp,0x0]
L_938ea4:
	ld_s r0,[r13,0xc]
L_938ea6:
	st_s r1,[r13,0x4]
L_938ea8:
	bset_s r0,r0,0x0
L_938eaa:
	st_s r0,[r13,0xc]
L_938eac:
	breq r1,0x1f,L_938ec4
L_938eb0:
	ld_s r0,[gp,-0xc0]
L_938eb2:
	brne r1,r0,L_938ebc
L_938eb6:
	cmp r0,0xff
L_938eba:
	bne_s L_938e9c
	.global L_938ebc
L_938ebc:
	bl.d L_93a088
L_938ec0:
	mov_s r0,r13
L_938ec2:
	b_s L_938f08
	.global L_938ec4
L_938ec4:
	mov_s r0,0x80
L_938ec6:
	bset_s r0,r0,0x19
L_938ec8:
	mov_s r32,r0
L_938eca:
	st.ab r0,[r25,0x4]
L_938ece:
	bclr r25,r25,0xa
L_938ed2:
	mov_s r0,0xeeee03
L_938ed8:
	mov_s r32,r0
L_938eda:
	st.ab r0,[r25,0x4]
L_938ede:
	bclr r25,r25,0xa
L_938ee2:
	bl.d L_92bbfc
L_938ee6:
	mov_s r0,r13
L_938ee8:
	ld_s r0,[gp,-0x48]
L_938eea:
	or r0,r0,0x27003f00
L_938ef2:
	mov_s r32,r0
L_938ef4:
	st.ab r0,[r25,0x4]
L_938ef8:
	bclr r25,r25,0xa
L_938efc:
	mov_s r1,0x8010b0
L_938f02:
	ld_s r0,[r1,0x48]
L_938f04:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938f06:
	st_s r0,[r1,0x48]
	.global L_938f08
L_938f08:
	b.d L_9202ac
L_938f0c:
	add_s sp,sp,0x4
L_938f0e:
	nop_s
