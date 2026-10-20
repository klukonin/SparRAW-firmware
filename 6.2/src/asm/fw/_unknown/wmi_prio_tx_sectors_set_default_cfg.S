/* wmi_prio_tx_sectors_set_default_cfg @ 0x8ecf54, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PRIO_TX_SECTORS_SET_DEFAULT_CFG_EVENT status %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, lmac_if_set_ss_sectors_default_cfg_handler, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_prio_tx_sectors_set_default_cfg
wmi_prio_tx_sectors_set_default_cfg:
	.global L_8ecf54
L_8ecf54:
	push_s blink
L_8ecf56:
	bl L_8c01dc
L_8ecf5a:
	sub_s sp,sp,0x4
L_8ecf5c:
	mov_s r14,r0
L_8ecf5e:
	mov_s r16,r1
L_8ecf60:
	bl.d L_8c33d0
L_8ecf64:
	mov_s r15,r2
L_8ecf66:
	mov_s r13,r0
L_8ecf68:
	bl.d L_8dbfa0
L_8ecf6c:
	mov_s r0,r16
L_8ecf6e:
	extb_s r2,r0
L_8ecf70:
	stb_s r0,[r13]
L_8ecf72:
	mov_s r1,0x100687c
L_8ecf78:
	bl.d L_8dcc10
L_8ecf7c:
	mov_s r0,0x2e
L_8ecf7e:
	mov_s r2,0x0
L_8ecf80:
	st_s r2,[sp,0x0]
L_8ecf82:
	mov_s r0,r14
L_8ecf84:
	mov_s r1,r13
L_8ecf86:
	mov_s r3,0x19a5
L_8ecf8c:
	mov r4,0x4
L_8ecf90:
	mov_s r5,r15
L_8ecf92:
	mov_s r6,r2
L_8ecf94:
	bl.d L_8e4fc4
L_8ecf98:
	mov_s r7,r2
L_8ecf9a:
	b.d L_8c0244
L_8ecf9e:
	add_s sp,sp,0x4
