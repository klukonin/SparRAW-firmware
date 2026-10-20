/* ut_hw_drivers_cmd_0x429 @ 0x8cf7fc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, ber_test__read_lane_counters
 */
	.section .text.ut_hw_drivers_cmd_0x429,"ax",@progbits
	.global ut_hw_drivers_cmd_0x429
ut_hw_drivers_cmd_0x429:
	.global L_8cf7fc
L_8cf7fc:
	push_s r13
L_8cf7fe:
	mov_s r2,0x885090
L_8cf804:
	add3_s r2,r2,r0
L_8cf806:
	ld_s r3,[r2]
L_8cf808:
	mov_s r2,0x885094
L_8cf80e:
	add3_s r2,r2,r0
L_8cf810:
	ld_s r2,[r2]
L_8cf812:
	asl_s r2,r2,0x18
L_8cf814:
	add_s r2,r2,r3
L_8cf816:
	st_s r2,[r1]
L_8cf818:
	mov_s r2,0x8850d0
L_8cf81e:
	mov_s r3,0x0
L_8cf820:
	add3_s r2,r2,r0
L_8cf822:
	st_s r3,[r1,0x4]
L_8cf824:
	ld_s r13,[r2]
L_8cf826:
	mov_s r2,0x8850d4
L_8cf82c:
	add3_s r2,r2,r0
L_8cf82e:
	ld_s r0,[r2]
L_8cf830:
	st_s r3,[r1,0xc]
L_8cf832:
	asl_s r0,r0,0x18
L_8cf834:
	add_s r13,r13,r0
L_8cf836:
	st_s r13,[r1,0x8]
L_8cf838:
	j_s.d [blink]
L_8cf83a:
	pop_s r13
