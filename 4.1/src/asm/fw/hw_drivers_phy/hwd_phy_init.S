/* hwd_phy_init @ 0x8ceff0, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_init() The Same as RESET Value: Address = 0x%08X, Data 0x%08X
 *   hw_drivers_phy.c
 * Зовут его: WBE_DRIVER__pcie_boot_init, hwd_phy__power_up_seq
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, fw_sysassert_fatal
 */
	.section .text.hwd_phy_init,"ax",@progbits
	.global hwd_phy_init
hwd_phy_init:
	.global L_8ceff0
L_8ceff0:
	push_s blink
L_8ceff2:
	bl L_8c02c4
L_8ceff6:
	mov_s r13,0x0
L_8ceff8:
	b_s L_8cf01e
	.global L_8ceffa
L_8ceffa:
	ld r4,[r3]
L_8ceffe:
	ld_s r0,[r14,0x4]
L_8cf000:
	brne r0,r4,L_8cf012
L_8cf004:
	mov_s r2,0x1018840
L_8cf00a:
	mov_s r0,0x1
L_8cf00c:
	bl.d L_8edff8
L_8cf010:
	mov_s r1,r0
	.global L_8cf012
L_8cf012:
	ld_s r1,[r14,0x4]
L_8cf014:
	ld_s r0,[r14]
L_8cf016:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cf018:
	st_s r1,[r0]
L_8cf01a:
	brhs r13,0x1f,L_8cf034
	.global L_8cf01e
L_8cf01e:
	mov_s r14,0x806784
L_8cf024:
	add3_s r14,r14,r13
L_8cf026:
	ld_s r3,[r14]
L_8cf028:
	brne r3,0xe0d0e0d,L_8ceffa
L_8cf030:
	b L_8c0334
	.global L_8cf034
L_8cf034:
	mov_s r0,blink
L_8cf036:
	mov_s r2,0x1018690
L_8cf03c:
	mov_s r1,0x133f
L_8cf042:
	bl.d L_8c82c0
L_8cf046:
	mov r3,0x7a6
L_8cf04a:
	b_s L_8cf01e
