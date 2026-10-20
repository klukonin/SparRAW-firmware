/* txss__init_sweep @ 0x935f54, 288 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_flows_txss.c
 * Зовут его: txss__flow_body
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_substate__set, mac__select_sector_and_wait_a, mac__select_sector_and_wait_b, mac_mode__switch_core_and_rf, rx_flow__run, sxd_hal__mac_write_indexed, txss_flow_step, uc_sysassert, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x8005d8, 0x800604, 0x800608
 */
	.section .text.txss__init_sweep,"ax",@progbits
	.global txss__init_sweep
txss__init_sweep:
	.global L_935f54
L_935f54:
	push_s blink
L_935f56:
	bl.d L_920214
L_935f5a:
	mov_s r1,0x4
L_935f5c:
	st.as 0x400000,[gp,0x38]
L_935f64:
	bl.d L_930dc4
L_935f68:
	mov_s r14,r0
L_935f6a:
	mov_s r0,0x1
L_935f6c:
	mov_s r1,r14
L_935f6e:
	bl.d L_936658
L_935f72:
	mov_s r2,0x0
L_935f74:
	mov_s r0,0x801a08
L_935f7a:
	ldw.as r1,[gp,0x58]
L_935f7e:
	ldw_s r0,[r0]
L_935f80:
	breq r1,r0,L_935fac
L_935f84:
	stw.as r0,[gp,0x58]
L_935f88:
	or r0,r0,0x1730000
L_935f90:
	mov_s r1,0x886d00
L_935f96:
	st_s r0,[r1]
L_935f98:
	sync
L_935f9c:
	mov_s r0,0x38000200
L_935fa2:
	mov_s r32,r0
L_935fa4:
	st.ab r0,[r25,0x4]
L_935fa8:
	bclr r25,r25,0xa
	.global L_935fac
L_935fac:
	mov_s r0,0x0
L_935fae:
	st.as r0,[gp,-0x7]
L_935fb2:
	mov_s r0,0x41
L_935fb4:
	asl_s r0,r0,0x13
L_935fb6:
	mov_s r32,r0
L_935fb8:
	st.ab r0,[r25,0x4]
L_935fbc:
	bclr r25,r25,0xa
L_935fc0:
	bl.d L_931338
L_935fc4:
	mov_s r0,0x5
L_935fc6:
	mov_s r13,0x1
L_935fc8:
	mov_s r1,0xdb3
L_935fce:
	bl.d L_9306ac
L_935fd2:
	mov_s r0,r13
	.global L_935fd4
L_935fd4:
	mov_s r0,0x0
L_935fd6:
	bset_s r0,r0,0x13
L_935fd8:
	mov_s r1,0x80
L_935fda:
	bl.d L_9318f4
L_935fde:
	mov_s r2,0x0
L_935fe0:
	mov_s r0,r42
L_935fe2:
	bbit1 r0,0x13,L_936020
L_935fe6:
	mov_s r0,r54
L_935fe8:
	bbit0 r0,0x7,L_936062
L_935fec:
	brhs r13,0x3,L_936054
L_935ff0:
	mov_s r1,0x801198
L_935ff6:
	asl_s r0,r14,0x3
L_935ff8:
	add3_s r0,r0,r0
L_935ffa:
	bl.d L_92a9f4
L_935ffe:
	ld_s r0,[r1,r0]
L_936000:
	mov_s r0,0x1
L_936002:
	mov_s r1,r14
L_936004:
	bl.d L_936658
L_936008:
	mov_s r2,r0
L_93600a:
	bl.d L_931664
L_93600e:
	mov_s r0,0x5
L_936010:
	mov_s r1,0xdb3
L_936016:
	bl.d L_9306ac
L_93601a:
	mov_s r0,0x1
L_93601c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_93601e:
	b_s L_935fd4
	.global L_936020
L_936020:
	bl L_92ce9c
L_936024:
	mov_s r0,0x801038
L_93602a:
	ld_s r0,[r0]
L_93602c:
	bbit1 r0,0x3,L_936042
L_936030:
	bbit1 r0,0x0,L_93604c
L_936034:
	bbit0 r0,0x2,L_935fd4
L_936038:
	mov_s r0,r14
L_93603a:
	bl.d L_930dc4
L_93603e:
	mov_s r1,0x7
L_936040:
	b_s L_936054
	.global L_936042
L_936042:
	mov_s r0,r14
L_936044:
	bl.d L_930dc4
L_936048:
	mov_s r1,0x5
L_93604a:
	b_s L_936054
	.global L_93604c
L_93604c:
	mov_s r0,r14
L_93604e:
	bl.d L_930dc4
L_936052:
	mov_s r1,0x6
	.global L_936054
L_936054:
	mov_s r0,0x0
L_936056:
	st.as r0,[gp,0x37]
L_93605a:
	b.d L_920284
L_93605e:
	st.as r0,[gp,0x38]
	.global L_936062
L_936062:
	mov_s r0,blink
L_936064:
	mov_s r2,0x10009b4
L_93606a:
	mov_s r1,0xd
L_93606c:
	bl.d L_925548
L_936070:
	mov_s r3,0xf6
L_936072:
	b_s L_935fd4
