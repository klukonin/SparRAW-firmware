/* phy__read_rx_counters @ 0x8d25e8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, link_lost_diag__rx_status, phy_stats__dump
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__read_rx_counters
phy__read_rx_counters:
	.global L_8d25e8
L_8d25e8:
	mov_s r1,0x883900
L_8d25ee:
	ld_s r2,[r1,0x64]
L_8d25f0:
	st_s r2,[r0]
L_8d25f2:
	ld_s r2,[r1,0x68]
L_8d25f4:
	st_s r2,[r0,0x4]
L_8d25f6:
	ld_s r2,[r1,0x74]
L_8d25f8:
	st_s r2,[r0,0x8]
L_8d25fa:
	ld_s r2,[r1,0x6c]
L_8d25fc:
	st_s r2,[r0,0xc]
L_8d25fe:
	ld_s r2,[r1,0x78]
L_8d2600:
	st_s r2,[r0,0x10]
L_8d2602:
	ld_s r2,[r1,0x70]
L_8d2604:
	st_s r2,[r0,0x14]
L_8d2606:
	ld_s r1,[r1,0x7c]
L_8d2608:
	mov_s r2,0x883980
L_8d260e:
	st_s r1,[r0,0x18]
L_8d2610:
	ld_s r1,[r2,0x20]
L_8d2612:
	st_s r1,[r0,0x1c]
L_8d2614:
	ld_s r1,[r2,0x24]
L_8d2616:
	st_s r1,[r0,0x20]
L_8d2618:
	ld_s r1,[r2,0x30]
L_8d261a:
	st_s r1,[r0,0x24]
L_8d261c:
	ld_s r1,[r2,0x28]
L_8d261e:
	st_s r1,[r0,0x28]
L_8d2620:
	ld_s r1,[r2,0x34]
L_8d2622:
	st_s r1,[r0,0x2c]
L_8d2624:
	ld_s r1,[r2,0x2c]
L_8d2626:
	st_s r1,[r0,0x30]
L_8d2628:
	ld_s r1,[r2,0x38]
L_8d262a:
	j_s.d [blink]
L_8d262c:
	st_s r1,[r0,0x34]
L_8d262e:
	nop_s
