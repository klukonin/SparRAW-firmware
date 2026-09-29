/* wmi_prio_tx_sectors_number @ 0x8ecfa0, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PRIO_TX_SECTORS_NUMBER_EVENT status %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, lmac_if_set_ss_sectors_number_handler, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_prio_tx_sectors_number
wmi_prio_tx_sectors_number:
	.global L_8ecfa0
L_8ecfa0:
	push_s blink
L_8ecfa2:
	bl L_8c01dc
L_8ecfa6:
	sub_s sp,sp,0x4
L_8ecfa8:
	mov_s r14,r0
L_8ecfaa:
	mov_s r16,r1
L_8ecfac:
	bl.d L_8c33d0
L_8ecfb0:
	mov_s r15,r2
L_8ecfb2:
	mov_s r13,r0
L_8ecfb4:
	bl.d L_8dc018
L_8ecfb8:
	mov_s r0,r16
L_8ecfba:
	extb_s r2,r0
L_8ecfbc:
	stb_s r0,[r13]
L_8ecfbe:
	mov_s r1,0x100683c
L_8ecfc4:
	bl.d L_8dcc10
L_8ecfc8:
	mov_s r0,0x2e
L_8ecfca:
	mov_s r2,0x0
L_8ecfcc:
	st_s r2,[sp,0x0]
L_8ecfce:
	mov_s r0,r14
L_8ecfd0:
	mov_s r1,r13
L_8ecfd2:
	mov_s r3,0x19a5
L_8ecfd8:
	mov r4,0x4
L_8ecfdc:
	mov_s r5,r15
L_8ecfde:
	mov_s r6,r2
L_8ecfe0:
	bl.d L_8e4fc4
L_8ecfe4:
	mov_s r7,r2
L_8ecfe6:
	b.d L_8c0244
L_8ecfea:
	add_s sp,sp,0x4
