/* hwd_phy__rgf_884100 @ 0x8d006c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__release_hw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_phy__rgf_884100,"ax",@progbits
	.global hwd_phy__rgf_884100
hwd_phy__rgf_884100:
	.global L_8d006c
L_8d006c:
	push_s blink
L_8d006e:
	bl L_8c02b8
L_8d0072:
	mov_s r14,0x884100
L_8d0078:
	st_s r0,[r14,0x30]
L_8d007a:
	mov r17,-0x100
L_8d007e:
	tst r1,r17
L_8d0082:
	mov_s r13,r1
L_8d0084:
	mov_s r16,r2
L_8d0086:
	bne_s L_8d00ae
	.global L_8d0088
L_8d0088:
	tst r16,r17
L_8d008c:
	bne_s L_8d00c2
	.global L_8d008e
L_8d008e:
	ld_s r2,[r14,0x34]
L_8d0090:
	mov_s r0,0xffff00ff
L_8d0096:
	mov_s r1,0xffff0000
L_8d009c:
	and_s r1,r1,r2
L_8d009e:
	and_s r13,r13,r0
L_8d00a0:
	or_s r13,r13,r1
L_8d00a2:
	asl r0,r16,0x8
L_8d00a6:
	or_s r0,r0,r13
L_8d00a8:
	st_s r0,[r14,0x34]
L_8d00aa:
	b L_8c031c
	.global L_8d00ae
L_8d00ae:
	mov_s r0,blink
L_8d00b0:
	mov_s r2,0x1018690
L_8d00b6:
	mov_s r1,0xad
L_8d00b8:
	bl.d L_8c82c0
L_8d00bc:
	mov r3,0x197
L_8d00c0:
	b_s L_8d0088
	.global L_8d00c2
L_8d00c2:
	mov_s r0,blink
L_8d00c4:
	mov_s r2,0x1018690
L_8d00ca:
	mov_s r1,0xae
L_8d00cc:
	bl.d L_8c82c0
L_8d00d0:
	mov r3,0x197
L_8d00d4:
	b_s L_8d008e
L_8d00d6:
	nop_s
