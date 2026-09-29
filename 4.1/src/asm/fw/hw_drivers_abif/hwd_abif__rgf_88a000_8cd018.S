/* hwd_abif__rgf_88a000_8cd018 @ 0x8cd018, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm__set_analog_path, ut_hw_modes_step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88a000_8cd018,"ax",@progbits
	.global hwd_abif__rgf_88a000_8cd018
hwd_abif__rgf_88a000_8cd018:
	.global L_8cd018
L_8cd018:
	push_s blink
L_8cd01a:
	bl L_8c02b8
L_8cd01e:
	mov_s r17,r0
L_8cd020:
	bic.f r0,r0,0x1f
L_8cd024:
	mov_s r16,r1
L_8cd026:
	bne_s L_8cd060
	.global L_8cd028
L_8cd028:
	mov_s r13,0x88a000
L_8cd02e:
	ld_s r1,[r13]
L_8cd030:
	asl r0,r17,0x10
L_8cd034:
	and r1,r1,0xffe0ffff
L_8cd03c:
	or_s r0,r0,r1
L_8cd03e:
	st_s r0,[r13]
L_8cd040:
	bic.f 0x0,r16,0x3f
L_8cd044:
	bne_s L_8cd074
	.global L_8cd046
L_8cd046:
	ld.as r0,[r13,0x81]
L_8cd04a:
	asl r1,r16,0x13
L_8cd04e:
	and r0,r0,0xfe07ffff
L_8cd056:
	or_s r0,r0,r1
L_8cd058:
	st.as r0,[r13,0x81]
L_8cd05c:
	b L_8c031c
	.global L_8cd060
L_8cd060:
	mov_s r0,blink
L_8cd062:
	mov_s r2,0x1019954
L_8cd068:
	mov_s r1,0xac
L_8cd06a:
	bl.d L_8c82c0
L_8cd06e:
	mov r3,0x20d
L_8cd072:
	b_s L_8cd028
	.global L_8cd074
L_8cd074:
	mov_s r0,blink
L_8cd076:
	mov_s r2,0x1019954
L_8cd07c:
	mov_s r1,0xac
L_8cd07e:
	bl.d L_8c82c0
L_8cd082:
	mov r3,0x20e
L_8cd086:
	b_s L_8cd046
