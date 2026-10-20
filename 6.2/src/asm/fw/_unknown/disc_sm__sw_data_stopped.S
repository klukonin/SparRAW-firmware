/* disc_sm__sw_data_stopped @ 0x8f9c1c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_cfg_rx_chain
 * Зовёт сам: __ld_r13_to_r13_ret, dma_mgr__configure_ring, fixed_sched__get_entry_count, pring__init_pool, tx_queue_mgr__create_queue, vring_schd__add_sniffer_vring
 * Глобалы (через gp): 0x80047c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global disc_sm__sw_data_stopped
disc_sm__sw_data_stopped:
	.global L_8f9c1c
L_8f9c1c:
	push_s blink
L_8f9c1e:
	push_s r13
L_8f9c20:
	bl.d L_8ccec8
L_8f9c24:
	sub_s sp,sp,0x4
L_8f9c26:
	mov_s r13,0x0
L_8f9c28:
	breq_s r0,0,L_8f9c7a
L_8f9c2a:
	mov_s r1,0x5
L_8f9c2c:
	st_s r1,[sp,0x0]
L_8f9c2e:
	mov_s r1,r13
L_8f9c30:
	mov_s r2,r13
L_8f9c32:
	mov_s r3,0x40
L_8f9c34:
	mov r4,0x2000
L_8f9c3c:
	mov r5,0x2800
L_8f9c44:
	mov r6,0x1f28
L_8f9c4c:
	bl.d L_8d9978
L_8f9c50:
	mov r7,0x1
L_8f9c54:
	bl L_8d8cb0
L_8f9c58:
	mov_s r0,r13
L_8f9c5a:
	mov_s r1,0x0
L_8f9c5c:
	bset_s r1,r1,0xd
L_8f9c5e:
	mov_s r2,0x5
L_8f9c60:
	bl.d L_8c2c14
L_8f9c64:
	asl_s r2,r2,0xb
L_8f9c66:
	mov_s r0,r13
L_8f9c68:
	mov_s r1,r13
L_8f9c6a:
	mov_s r2,r13
L_8f9c6c:
	mov_s r3,r13
L_8f9c6e:
	mov_s r4,r13
L_8f9c70:
	mov_s r5,r13
L_8f9c72:
	mov_s r6,r13
L_8f9c74:
	bl.d L_8c6e90
L_8f9c78:
	mov_s r7,r13
	.global L_8f9c7a
L_8f9c7a:
	mov_s r0,0x1
L_8f9c7c:
	mov_s r1,0x0
L_8f9c7e:
	mov_s r2,r1
L_8f9c80:
	mov_s r3,r1
L_8f9c82:
	mov_s r4,r1
L_8f9c84:
	mov_s r5,r1
L_8f9c86:
	mov_s r6,r1
L_8f9c88:
	bl.d L_8c6e90
L_8f9c8c:
	mov_s r7,r1
L_8f9c8e:
	mov_s r0,0x1
L_8f9c90:
	mov_s r1,0x9
L_8f9c92:
	asl_s r1,r1,0xb
L_8f9c94:
	mov_s r2,0x0
L_8f9c96:
	bl.d L_8c2c14
L_8f9c9a:
	bset_s r2,r2,0xb
L_8f9c9c:
	st.as r13,[gp,0xbe]
L_8f9ca0:
	b.d L_8c025c
L_8f9ca4:
	add_s sp,sp,0x4
L_8f9ca6:
	nop_s
