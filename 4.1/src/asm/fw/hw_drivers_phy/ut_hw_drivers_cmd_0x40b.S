/* ut_hw_drivers_cmd_0x40b @ 0x8cff30, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x40b,"ax",@progbits
	.global ut_hw_drivers_cmd_0x40b
ut_hw_drivers_cmd_0x40b:
	.global L_8cff30
L_8cff30:
	push_s blink
L_8cff32:
	bl L_8c02b8
L_8cff36:
	mov_s r15,r0
L_8cff38:
	mov_s r13,r1
L_8cff3a:
	cmp_s r1,0x17ff
L_8cff40:
	bhi.d L_8cffd4
L_8cff44:
	mov_s r16,r2
	.global L_8cff46
L_8cff46:
	bclr.f 0x0,r15,0x0
L_8cff4a:
	bne_s L_8cffea
	.global L_8cff4c
L_8cff4c:
	mov_s r14,0x884100
L_8cff52:
	ld_s r0,[r14,0x4c]
L_8cff54:
	mov_s r1,0x884000
L_8cff5a:
	bclr_s r0,r0,0x0
L_8cff5c:
	or_s r0,r0,r15
L_8cff5e:
	st_s r0,[r14,0x4c]
L_8cff60:
	ld_s r0,[r1,0x8]
L_8cff62:
	cmp r13,0x7ff
L_8cff66:
	bset_s r0,r0,0x0
L_8cff68:
	st_s r0,[r1,0x8]
L_8cff6a:
	mov r17,0x1
L_8cff6e:
	sub.ls r17,r17,r17
L_8cff72:
	cmp_s r13,0xfff
L_8cff78:
	mov_s r15,0x1
L_8cff7a:
	sub.ls r15,r15,r15
L_8cff7e:
	bclr.f 0x0,r17,0x0
L_8cff82:
	bne_s L_8cfffe
	.global L_8cff84
L_8cff84:
	bclr.f 0x0,r15,0x0
L_8cff88:
	bne_s L_8d0012
	.global L_8cff8a
L_8cff8a:
	mov_s r0,0x880180
L_8cff90:
	ld_s r1,[r0,0x60]
L_8cff92:
	asl r2,r17,0x7
L_8cff96:
	bic r1,r1,0xc0
L_8cff9a:
	bset_s r1,r1,0x6
L_8cff9c:
	or_s r1,r1,r2
L_8cff9e:
	bclr_s r1,r1,0x8
L_8cffa0:
	asl_s r15,r15,0x8
L_8cffa2:
	or_s r15,r15,r1
L_8cffa4:
	st_s r15,[r0,0x60]
L_8cffa6:
	ld_s r0,[r14,0x50]
L_8cffa8:
	mov_s r15,0xffffe000
L_8cffae:
	and_s r0,r0,r15
L_8cffb0:
	st_s r0,[r14,0x50]
L_8cffb2:
	tst_s r13,r15
L_8cffb4:
	bne_s L_8d0026
	.global L_8cffb6
L_8cffb6:
	ld_s r0,[r14,0x54]
L_8cffb8:
	and_s r0,r0,r15
L_8cffba:
	or_s r13,r13,r0
L_8cffbc:
	st_s r13,[r14,0x54]
L_8cffbe:
	ld_s r0,[r14,0x40]
L_8cffc0:
	bset_s r0,r0,0x0
L_8cffc2:
	st_s r0,[r14,0x40]
L_8cffc4:
	ld_s r0,[r14,0x58]
L_8cffc6:
	st r16,[r14, 0x58]
L_8cffca:
	ld_s r0,[r14,0x44]
L_8cffcc:
	bset_s r0,r0,0x0
L_8cffce:
	st_s r0,[r14,0x44]
L_8cffd0:
	b L_8c031c
	.global L_8cffd4
L_8cffd4:
	mov_s r0,blink
L_8cffd6:
	mov_s r2,0x1018690
L_8cffdc:
	mov_s r1,0xdd
L_8cffde:
	bset_s r1,r1,0xc
L_8cffe0:
	bl.d L_8c82c0
L_8cffe4:
	mov r3,0x150
L_8cffe8:
	b_s L_8cff46
	.global L_8cffea
L_8cffea:
	mov_s r0,blink
L_8cffec:
	mov_s r2,0x1018690
L_8cfff2:
	mov_s r1,0xac
L_8cfff4:
	bl.d L_8c82c0
L_8cfff8:
	mov r3,0x155
L_8cfffc:
	b_s L_8cff4c
	.global L_8cfffe
L_8cfffe:
	mov_s r0,blink
L_8d0000:
	mov_s r2,0x1018690
L_8d0006:
	mov_s r1,0xb0
L_8d0008:
	bl.d L_8c82c0
L_8d000c:
	mov r3,0x161
L_8d0010:
	b_s L_8cff84
	.global L_8d0012
L_8d0012:
	mov_s r0,blink
L_8d0014:
	mov_s r2,0x1018690
L_8d001a:
	mov_s r1,0xb1
L_8d001c:
	bl.d L_8c82c0
L_8d0020:
	mov r3,0x161
L_8d0024:
	b_s L_8cff8a
	.global L_8d0026
L_8d0026:
	mov_s r0,blink
L_8d0028:
	mov_s r2,0x1018690
L_8d002e:
	mov_s r1,0xac
L_8d0030:
	bl.d L_8c82c0
L_8d0034:
	mov r3,0x164
L_8d0038:
	b_s L_8cffb6
L_8d003a:
	nop_s
