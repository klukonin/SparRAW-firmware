/* ut_hw_modes_cmd_0x304 @ 0x8d5164, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: __ld_r13_ret, hw_modes__pll_bypass, hw_modes__pll_engage, ut_hw_drivers_cmd_0x131
 */
	.section .text.ut_hw_modes_cmd_0x304,"ax",@progbits
	.global ut_hw_modes_cmd_0x304
ut_hw_modes_cmd_0x304:
	.global L_8d5164
L_8d5164:
	push_s blink
L_8d5166:
	push_s r13
L_8d5168:
	brne_s r1,0,L_8d5196
L_8d516a:
	mov_s r13,0x889480
L_8d5170:
	brne r0,0x1,L_8d5186
L_8d5174:
	bl L_8d4c8c
L_8d5178:
	ld_s r0,[r13,0x24]
L_8d517a:
	bset_s r0,r0,0x0
L_8d517c:
	st_s r0,[r13,0x24]
L_8d517e:
	bl.d L_8cb8b0
L_8d5182:
	mov_s r0,0x0
L_8d5184:
	b_s L_8d5196
	.global L_8d5186
L_8d5186:
	bl.d L_8cb8b0
L_8d518a:
	mov_s r0,0x1
L_8d518c:
	ld_s r0,[r13,0x24]
L_8d518e:
	bclr_s r0,r0,0x0
L_8d5190:
	st_s r0,[r13,0x24]
L_8d5192:
	bl L_8d4c58
	.global L_8d5196
L_8d5196:
	b L_8c033c
L_8d519a:
	nop_s
