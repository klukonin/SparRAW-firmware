/* txss_resp__wait_fdbk @ 0x93be68, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_resp__flow
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf__store_flow_status, mac_evt__enable_bit_sync_b, rx_flow__run, sls__clear_rx_state, sxd_hal__wait_slot2_busy2, uc_sysassert
 * Глобалы (через gp): 0x8005be, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss_resp__wait_fdbk
txss_resp__wait_fdbk:
	.global L_93be68
L_93be68:
	push_s blink
L_93be6a:
	bl L_920230
L_93be6e:
	push_s r0
L_93be70:
	mov_s r0,0x8021e0
L_93be76:
	ld_s r15,[r0]
L_93be78:
	st.as 0x800000,[gp,0x34]
L_93be80:
	lsr_s r15,r15,0x2
L_93be82:
	bl.d L_936544
L_93be86:
	mov_s r0,0x5
L_93be88:
	bmsk_s r15,r15,0x0
L_93be8a:
	b_s L_93be94
	.global L_93be8c
L_93be8c:
	mov_s r0,blink
L_93be8e:
	bl.d L_926618
L_93be92:
	mov_s r1,0xe
	.global L_93be94
L_93be94:
	bl.d L_936cc8
L_93be98:
	ldw_s r0,[gp,-0x20]
L_93be9a:
	ldw.as r1,[gp,0x4b]
L_93be9e:
	mov_s r13,r0
L_93bea0:
	mov_s r0,0x802968
L_93bea6:
	ldw_s r0,[r0]
L_93bea8:
	breq r1,r0,L_93bed4
L_93beac:
	stw.as r0,[gp,0x4b]
L_93beb0:
	or r0,r0,0x1730000
L_93beb8:
	mov_s r1,0x886d00
L_93bebe:
	st_s r0,[r1]
L_93bec0:
	sync
L_93bec4:
	mov_s r0,0x38000200
L_93beca:
	mov_s r32,r0
L_93becc:
	st.ab r0,[r25,0x4]
L_93bed0:
	bclr r25,r25,0xa
	.global L_93bed4
L_93bed4:
	mov_s r14,0x0
L_93bed6:
	st.as r14,[gp,-0x6]
L_93beda:
	breq_s r13,0,L_93bee2
L_93bedc:
	bl.d L_930dd4
L_93bee0:
	mov_s r15,r14
	.global L_93bee2
L_93bee2:
	mov_s r0,0x8021e0
L_93bee8:
	ld_s r0,[r0]
L_93beea:
	bbit1 r0,0x0,L_93bf02
L_93beee:
	bbit1 r0,0x3,L_93be8c
L_93bef2:
	bbit1 r0,0x2,L_93bf0c
L_93bef6:
	mov_s r0,r54
L_93bef8:
	bbit0 r0,0x6,L_93be94
L_93befc:
	ld_s r0,[sp,0x0]
L_93befe:
	mov_s r1,0xa
L_93bf00:
	b_s L_93bf06
	.global L_93bf02
L_93bf02:
	ld_s r0,[sp,0x0]
L_93bf04:
	mov_s r1,0xb
	.global L_93bf06
L_93bf06:
	bl L_9357cc
L_93bf0a:
	b_s L_93bf0e
	.global L_93bf0c
L_93bf0c:
	mov_s r15,0x1
	.global L_93bf0e
L_93bf0e:
	cmp_s r13,0x0
L_93bf10:
	bl.eq L_92ed50
L_93bf14:
	mov_s r0,r15
L_93bf16:
	b.d L_92029c
L_93bf1a:
	add_s sp,sp,0x4
