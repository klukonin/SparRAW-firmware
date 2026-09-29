/* hw_modes__apply_power_mode @ 0x8d5014, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_modes_power_manager.c
 * Зовут его: UT_HW_MODES_cmd_handler, ut_hw_modes_cmd_0x308
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, hwd_abif__rgf_880b80, hwd_dma__set_prio_map_by_mode, hwd_mac__set_prio_map_by_mode, hwd_pcie__set_mode_map, hwd_phy__set_880c00
 */
	.section .text.hw_modes__apply_power_mode,"ax",@progbits
	.global hw_modes__apply_power_mode
hw_modes__apply_power_mode:
	.global L_8d5014
L_8d5014:
	push_s blink
L_8d5016:
	bl L_8c02c4
L_8d501a:
	mov_s r13,r0
L_8d501c:
	brhs.d r0,0x5,L_8d5034
L_8d5020:
	mov_s r14,r1
L_8d5022:
	ldb.x r10,[0x802f1c,r13]
L_8d502a:
	add r0,pcl,0xc
L_8d502e:
	add1 r0,r0,r10
L_8d5032:
	j_s [r0]
	.global L_8d5034
L_8d5034:
	mov_s r0,blink
L_8d5036:
	mov_s r2,0x10182b8
L_8d503c:
	mov_s r1,0x12dd
L_8d5042:
	bl.d L_8c82c0
L_8d5046:
	mov r3,0x14f
L_8d504a:
	ld_s r0,[r14]
L_8d504c:
	btst_s r0,0x0
L_8d504e:
	bl.ne.d L_8cdb40
L_8d5052:
	mov.ne r0,r13
L_8d5056:
	ld_s r0,[r14]
L_8d5058:
	btst_s r0,0x1
L_8d505a:
	bl.ne.d L_8cec0c
L_8d505e:
	mov.ne r0,r13
L_8d5062:
	ld_s r0,[r14]
L_8d5064:
	btst_s r0,0x2
L_8d5066:
	bl.ne.d L_8cf07c
L_8d506a:
	mov.ne r0,r13
L_8d506e:
	ld_s r0,[r14]
L_8d5070:
	btst_s r0,0x3
L_8d5072:
	bl.ne.d L_8ce1e4
L_8d5076:
	mov.ne r0,r13
L_8d507a:
	ld_s r0,[r14]
L_8d507c:
	btst_s r0,0x4
L_8d507e:
	bl.ne.d L_8cd230
L_8d5082:
	mov.ne r0,r13
L_8d5086:
	b L_8c0334
L_8d508a:
	nop_s
