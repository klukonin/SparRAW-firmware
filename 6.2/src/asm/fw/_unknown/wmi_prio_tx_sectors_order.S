/* wmi_prio_tx_sectors_order @ 0x8ecfec, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PRIO_TX_SECTORS_ORDER_EVENT status %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, lmac_if_set_ss_sectors_order_handler, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_prio_tx_sectors_order
wmi_prio_tx_sectors_order:
	.global L_8ecfec
L_8ecfec:
	push_s blink
L_8ecfee:
	bl L_8c01dc
L_8ecff2:
	sub_s sp,sp,0x4
L_8ecff4:
	mov_s r14,r0
L_8ecff6:
	mov_s r16,r1
L_8ecff8:
	bl.d L_8c33d0
L_8ecffc:
	mov_s r15,r2
L_8ecffe:
	mov_s r13,r0
L_8ed000:
	bl.d L_8dc080
L_8ed004:
	mov_s r0,r16
L_8ed006:
	extb_s r2,r0
L_8ed008:
	stb_s r0,[r13]
L_8ed00a:
	mov_s r1,0x10067fc
L_8ed010:
	bl.d L_8dcc10
L_8ed014:
	mov_s r0,0x2e
L_8ed016:
	mov_s r2,0x0
L_8ed018:
	st_s r2,[sp,0x0]
L_8ed01a:
	mov_s r0,r14
L_8ed01c:
	mov_s r1,r13
L_8ed01e:
	mov_s r3,0x19a5
L_8ed024:
	mov r4,0x4
L_8ed028:
	mov_s r5,r15
L_8ed02a:
	mov_s r6,r2
L_8ed02c:
	bl.d L_8e4fc4
L_8ed030:
	mov_s r7,r2
L_8ed032:
	b.d L_8c0244
L_8ed036:
	add_s sp,sp,0x4
